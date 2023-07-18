

class HttpResponseCatcher < MoesifApi::HttpCallBack
  attr_accessor :response

  def on_before_request(request)
  end

  # Catching the response
  def on_after_response(context)
    @response = context.response
    print "I am here in on after response\n"
    print "is type a string " + @response.raw_body.is_a?(String).to_s
    print @response.raw_body
    print "\nfnished printing raw body"
  end
end
