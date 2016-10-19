

module MoesifApi
  class UnirestClient < HttpClient
    # Method overridden from HttpClient.
    def execute_as_string(http_request)
      if http_request.username || http_request.password
        auth = {:user=>http_request.username, :password=>http_request.password}
      end 

      response = Unirest.method(http_request.http_method.downcase).call(http_request.query_url, 
        headers: http_request.headers, parameters: http_request.parameters,
        auth: auth)

      return convert_response(response)
    end

    # Method overridden from HttpClient.
    def execute_as_binary(http_request)
      if http_request.username || http_request.password
        auth = {:user=>http_request.username, :password=>http_request.password}
      end 

      response = Unirest.method(http_request.http_method.downcase).call(http_request.query_url, 
        headers: http_request.headers, parameters: http_request.parameters,
        auth: auth)

      return convert_response(response)
    end

    # Method overridden from HttpClient.
    def convert_response(response)
      return HttpResponse.new(response.code, response.headers.dup, response.raw_body.dup)
    end
  end
end