require 'zlib'
require 'net/http'

module MoesifApi
  class ApiController < BaseController
    @@instance = ApiController.new
    # Singleton instance of the controller class
    def self.instance
      @@instance
    end

    # API Call to send data to Moesif 
    # @param [EventModel] body Required [Hash] headers Required [String] url Required
    # @return response and context from the API call
    def send_moesif(url, headers, body)
      begin
        # Gzip the body
        gzip = Zlib::GzipWriter.new(StringIO.new)
        gzip << body.to_json
        gzip_body = gzip.close.string

        # Add Content-Encoding header
        headers['Content-Encoding'] = 'gzip'
         # Gzip payload
         _request_body = gzip_body
      rescue => e
         # Json payload
         _request_body = body.to_json
      end

      # Create the HttpRequest object for the call
      _request = @http_client.post url, headers: headers, parameters: _request_body

      # Call the on_before_request callback
      @http_call_back.on_before_request(_request) if @http_call_back

      # Invoke the API call and get the response
      _response = @http_client.execute_as_string(_request)

      # Wrap the request and response in an HttpContext object
      _context = HttpContext.new(_request, _response)

      # Call the on_after_response callback
      @http_call_back.on_after_response(_context) if @http_call_back

      return _response, _context
    end

    # Add Single API Event Call
    # @param [EventModel] body Required parameter: Example:
    # @return void response from the API call
    def create_event(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/events'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)

      # Return response headers
      return _response.headers
    end

    # Add multiple API Events in a single batch (batch size must be less than 250kb)
    # @param [List of EventModel] body Required parameter: Example:
    # @return void response from the API call
    def create_events_batch(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/events/batch'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)

      # Return response headers
      return _response.headers
    end

    # Update Data for a Single User
    # @param [UserModel] body Required parameter.
    # @return void response from the API call
    def update_user(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/users'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)
    end


    # Update Data for multiple Users in a single batch (batch size must be less than 250kb)
    # @param [list of UserModel] body Required parameter.
    # @return void response from the API call
    def update_users_batch(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/users/batch'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)
    end

    # Get Application configuration
    # @param void Required parameter.
    # @return response from the API call
    def get_app_config()
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/config'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id
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

      # Return the response
      return _response
    end

    # Update Data for a Single Company
    # @param [CompanyModel] body Required parameter.
    # @return void response from the API call
    def update_company(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/companies'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)
    end

    # Update Data for multiple Companies in a single batch (batch size must be less than 250kb)
    # @param [list of CompanyModel] body Required parameter.
    # @return void response from the API call
    def update_companies_batch(body)
      # the base uri for api requests
      _query_builder = Configuration.base_uri.dup

      # prepare query string for API call
      _query_builder << '/v1/companies/batch'

      # validate and preprocess url
      _query_url = APIHelper.clean_url _query_builder

      # prepare headers
      _headers = {
        'content-type' => 'application/json; charset=utf-8',
        'X-Moesif-Application-Id' => Configuration.application_id,
        'User-Agent' => 'moesifapi-ruby/' +  Configuration.version
      }

      # Create the HttpRequest object for the call, fetch and wrap the respone in a HttpContext object
      _response, _context = send_moesif(_query_url, _headers, body)

      # Global error handling using HTTP status codes.
      validate_response(_context)
    end
  end
end
