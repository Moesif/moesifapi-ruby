require 'faraday'
require 'json'

faraday_version = Gem.loaded_specs['faraday'].version

# in faraday < 2.0 net_http_persistent and retry is build into faraday already
# in faraday >= 2.0 we must require these plugins
if faraday_version >= Gem::Version.new('2.0')
  require 'faraday/net_http_persistent'
  require 'faraday/retry'
end

module MoesifApi
  class FaradayClient < HttpClient
    def initialize
      super()
      retry_options = {
        max: Configuration.retry_count,
        interval: 0.2,
        interval_randomness: 0.5,
        backoff_factor: 2
      }

      @connection = Faraday.new({}) do |f|
        f.request :retry, retry_options
        f.adapter :net_http_persistent, pool_size: 5 do |http|
          http.idle_timeout = 100
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
