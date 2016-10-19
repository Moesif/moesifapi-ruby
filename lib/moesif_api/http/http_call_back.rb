

module MoesifApi
  class HttpCallBack
    # A controller will call this method before making an HTTP Request.
    # @param [HttpRequest] The HttpRequest object which the HttpClient will execute.
    def on_before_request(http_request)
      raise NotImplementedError, "This method needs to be implemented in a child class."
    end
    
    # A controller will call this method after making an HTTP Request.
    # @param [HttpResponse] The HttpResponse object received from the HttpClient.
    def on_after_response(http_response)
      raise NotImplementedError, "This method needs to be implemented in a child class."
    end
  end
end