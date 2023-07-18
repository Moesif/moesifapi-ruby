module MoesifApi
  class BaseController
    attr_accessor :http_client, :http_call_back

    @@faraday_http_client = FaradayClient.new
    # if ever weant to switch to @unirest we can switch to below
    # @@unirest_http_client = UnirestClient.new

    def initialize(http_client: nil, http_call_back: nil)
      @http_client = http_client ||= @@faraday_http_client
      @http_call_back = http_call_back
    end

    def validate_response(context)
      return if context.response.status_code.between?(200, 208) # [200,208] = HTTP OK

      raise APIException.new 'HTTP Response Not OK', context
    end
  end
end
