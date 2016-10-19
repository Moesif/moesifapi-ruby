

module MoesifApi
  class HttpContext
    attr_accessor :request, :response

    # The constructor.
    # @param [HttpRequest] An HttpRequest object representing the HTTP request.
    # @param [HttpResponse] An HttpResponse object representing the HTTP response.
    def initialize(request, response)
      @request = request
      @response = response
    end
  end
end