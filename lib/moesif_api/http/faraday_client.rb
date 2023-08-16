require 'faraday'
require 'json'

if faraday_version >= Gem::Version.new('2.5')
  require 'faraday/net_http_persistent'
  require 'faraday/retry'
end

module MoesifApi
  class FaradayClient < HttpClient
    def initialize
      super()
      retry_options = {
        max: 3,
        interval: 0.1,
        interval_randomness: 0.5,
        backoff_factor: 2
      }
      if Gem.loaded_specs['faraday'].version < Gem::Version.new('2.5')
        # For Faraday 1.x to 2.5 no advanced features
        @connection = Faraday.new({})
      else
        # Use Faraday 2.x specific code here
        @connection = Faraday.new({}) do |f|
          f.request :retry, retry_options
          f.adapter :net_http_persistent, pool_size: 5 do |http|
            http.idle_timeout = 100
          end
        end
      end
    end

    # Method overridden from HttpClient.
    def execute_as_string(http_request)
      response = @connection.run_request(http_request.http_method.downcase.to_sym,
                                         http_request.query_url,
                                         http_request.parameters, # body
                                         http_request.headers)

      convert_response(response)
    end

    # Method overridden from HttpClient.
    def convert_response(response)
      if response.body.is_a?(String)
        raw_body = response.body
      elsif !response.body.nil?
        raw_body = JSON.generate(response.body)
      end

      HttpResponse.new(response.status, response.headers.dup, raw_body)
    end
  end
end
