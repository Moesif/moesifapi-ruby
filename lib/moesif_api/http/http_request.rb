

module MoesifApi
  class HttpRequest
    attr_accessor :http_method, :query_url, :headers, :parameters, :username, :password

    # The constructor.	
    # @param [HttpMethodEnum] The HTTP method.
    # @param [String] The URL to send the request to.
    # @param [Hash, Optional] The headers for the HTTP Request.
    # @param [Hash, Optional] The parameters for the HTTP Request.
    # @param [String, Optional] Username for Basic Auth requests.
    # @param [String, Optional] Password for Basic Auth requests.
    def initialize(http_method,
                   query_url,
                   headers: nil,
                   parameters: nil,
                   username: nil,
                   password: nil)
      @http_method = http_method
      @query_url = query_url
      @headers = headers
      @parameters = parameters
      @username = username
      @password = password
    end
  end
end
