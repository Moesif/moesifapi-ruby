require 'faraday'
require 'faraday/net_http_persistent'
require 'faraday/retry'

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

      @connection = Faraday.new({}) do |f|
        f.request :retry, retry_options
        f.adapter :net_http_persistent, pool_size: 5 do |http|
          http.idle_timeout = 100
        end
      end
    end

    # Method overridden from HttpClient.
    def execute_as_string(http_request)
      if http_request.username || http_request.password
        auth = { user: http_request.username, password: http_request.password }
      end
      response = @connection.run_request(http_request.http_method.downcase.to_sym,
                                         http_request.query_url,
                                         http_request.parameters, # body
                                         http_request.headers)

      # response = Unirest.method(http_request.http_method.downcase).call(http_request.query_url,
      #                                                                   headers: http_request.headers, parameters: http_request.parameters,
      #                                                                   auth: auth)

      convert_response(response)
    end

    # Method overridden from HttpClient.
    def execute_as_binary(http_request)
      if http_request.username || http_request.password
        auth = { user: http_request.username, password: http_request.password }
      end

      response = @connection.run_request(http_request.http_method.downcase.to_sym,
                                         http_request.query_url,
                                         http_request.parameters, # body
                                         http_request.headers)

      convert_response(response)
    end

    # Method overridden from HttpClient.
    def convert_response(response)
      HttpResponse.new(response.status, response.headers.dup, response.body)
    end
  end
end
