module MoesifApi
  class BaseController
    attr_accessor :http_client, :http_call_back

    @@faraday_http_client = FaradayClient.new

    def initialize(http_client: nil, http_call_back: nil)
      @http_client = http_client ||= @@faraday_http_client
      @http_call_back = http_call_back
    end

    def build_request_headers
      {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => Configuration.user_agent || ('moesifapi-ruby/' +  Configuration.version)
      }
    end

    def validate_response(context)
      return if context.response.status_code.between?(200, 208) # [200,208] = HTTP OK

      raise APIException.new 'HTTP Response Not OK', context
    end

  end
end
