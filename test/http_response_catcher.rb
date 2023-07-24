

class HttpResponseCatcher < MoesifApi::HttpCallBack
  attr_accessor :response

  def on_before_request(request)
  end

  # Catching the response
  def on_after_response(context)
    @response = context.response
    # print "I am here in on after response\n"
    # print "response raw_body is a string " + @response.raw_body.is_a?(String).to_s + "\n"
    # print @response.raw_body + "\n"
    # print "response json_body is a hash" + @response.json_body.is_a?(Hash).to_s
    # print @response.json_body.to_s
    # print "\nfnished printing json body"
  end
end
