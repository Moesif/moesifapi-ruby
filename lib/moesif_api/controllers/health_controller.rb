

module MoesifApi
  class HealthController < BaseController
    @@instance = HealthController.new
    # Singleton instance of the controller class
    def self.instance
      @@instance
    end

    # Health Probe
    # @return StatusModel response from the API call
    def get_health_probe
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/health/probe'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'accept' => 'application/json',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call
      _request = @http_client.get _query_url, headers: _headers

      # Call the on_before_request callback
      @http_call_back.on_before_request(_request) if @http_call_back

      # Invoke the API call and get the response
      _response = @http_client.execute_as_string(_request)

      # Wrap the request and response in an HttpContext object
      _context = HttpContext.new(_request, _response)

      # Call the on_after_response callback
      @http_call_back.on_after_response(_context) if @http_call_back

      # Global error handling using HTTP status codes.
      validate_response(_context)

      # Return appropriate response type
      decoded = APIHelper.json_deserialize(_response.raw_body)
      return StatusModel.from_hash(decoded)
    end
  end
end
