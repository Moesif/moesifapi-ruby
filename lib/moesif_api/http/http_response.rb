

module MoesifApi
  class HttpResponse
    attr_accessor :status_code, :headers, :raw_body, :json_body

    # The constructor.
    # @param [Integer] The status code returned by the server.
    # @param [Hash] The headers sent by the server in the response.
    # @param [String] The raw body of the response.
    def initialize(status_code,
                   headers,
                   raw_body)
      @status_code = status_code
      @headers = headers
      @raw_body = raw_body

      begin
        if !raw_body.nil? and raw_body.is_a?(String) and (raw_body.start_with?("{") || raw_body.start_with?("["))
          @json_body = JSON.parse(raw_body)
        end
      rescue StandardError => e
        # we can't parse json body
        # but it is ok, move forward anyways
        # print "can't parse json " + e.to_s
      end
    end
  end
end
