

require 'time'
require_relative 'controller_test_base'

class ApiControllerTests < ControllerTestBase
  # Called only once for the class before any test has executed
  def self.startup
    self.controller = @@api_client.api
  end

  # Add Single Event via Injestion API
  def test_add_event()
    # Parameters for the API call

    req_headers = JSON.parse('{'\
      '"Host": "api.acmeinc.com",'\
      '"Accept": "*/*",'\
      '"Connection": "Keep-Alive",'\
      '"User-Agent": "Dalvik/2.1.0 (Linux; U; Android 5.0.2; C6906 Build/14.5.A.0.242)",'\
      '"Content-Type": "application/json",'\
      '"Content-Length": "126",'\
      '"Accept-Encoding": "gzip"'\
    '}')

    req_body = JSON.parse( '{'\
      '"items": ['\
        '{'\
          '"type": 1,'\
          '"id": "fwfrf"'\
        '},'\
        '{'\
          '"type": 2,'\
          '"id": "d43d3f"'\
        '}'\
      ']'\
    '}')

    rsp_headers = JSON.parse('{'\
      '"Date": "Tue, 6 Jan 2019 23:46:49 GMT",'\
                    '"Vary": "Accept-Encoding",'\
      '"Pragma": "no-cache",'\
      '"Expires": "-1",'\
      '"Content-Type": "application/json; charset=utf-8",'\
                    '"Cache-Control": "no-cache"'\
    '}')

    rsp_body = JSON.parse('{'\
      '"Error": "InvalidArgumentException",'\
      '"Message": "Missing field field_a"'\
    '}')

    metadata = JSON.parse('{'\
      '"foo": "rubytestmeta",'\
      '"bar": "rubytestmedat2"'\
    '}')

    event_req = EventRequestModel.new()
    event_req.time = Time.now.utc.iso8601
    event_req.uri = "https://api.acmeinc.com/items/reviews/"
    event_req.verb = "PATCH"
    event_req.api_version = "1.1.0"
    event_req.ip_address = "61.48.220.123"
    event_req.headers = req_headers
    event_req.body = req_body

    event_rsp = EventResponseModel.new()
    event_rsp.time = (Time.now.utc + 2).iso8601
    event_rsp.status = 500
    event_rsp.headers = rsp_headers
    event_rsp.body = rsp_body

    event_model = EventModel.new()
    event_model.request = event_req
    event_model.response = event_rsp
    event_model.user_id = "my_user_id"
    event_model.company_id = "my_company_id"
    event_model.metadata = metadata
    event_model.session_token = "23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"

    # Perform the API call through the SDK function
    self.class.controller.create_event(event_model)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end

  # Add Batched Events via Ingestion API
  def test_add_batched_events()
    # Parameters for the API call
    body = JSON.parse('[{"metadata":{"foo":"ruby"},"request":{"time":"2019-01-09T04:45:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"response":{"time":"2019-01-09T04:45:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"},{"request":{"time":"2019-01-09T04:46:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"response":{"time":"2019-01-09T04:46:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"},{"request":{"time":"2019-01-09T04:47:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"response":{"time":"2019-01-09T04:47:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"},{"request":{"time":"2019-01-09T04:48:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"metadata":{"bar":"ruby"},"response":{"time":"2019-01-09T04:48:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"exfzweachxjgznvKUYrxFcxv]s98y18cx98q3yhwmnhcfx43f"},{"request":{"time":"2019-01-09T04:49:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"response":{"time":"2019-01-09T04:49:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"},{"request":{"time":"2019-01-09T04:50:42.914","uri":"https://api.acmeinc.com/items/reviews/","verb":"PATCH","api_version":"1.1.0","ip_address":"61.48.220.123","headers":{"Host":"api.acmeinc.com","Accept":"*/*","Connection":"Keep-Alive","User-Agent":"Dalvik/2.1.0(Linux;U;Android5.0.2;C6906Build/14.5.A.0.242)","Content-Type":"application/json","Content-Length":"126","Accept-Encoding":"gzip"},"body":{"items":[{"direction_type":1,"discovery_id":"fwfrf","liked":false},{"direction_type":2,"discovery_id":"d43d3f","liked":true}]}},"response":{"time":"2019-01-09T04:50:42.914","status":500,"headers":{"Date":"Tue,6Jan201923:46:49GMT","Vary":"Accept-Encoding","Pragma":"no-cache","Expires":"-1","Content-Type":"application/json;charset=utf-8","X-Powered-By":"ARR/3.0","Cache-Control":"no-cache","Arr-Disable-Session-Affinity":"true"},"body":{"Error":"InvalidArgumentException","Message":"Missingfieldfield_a"}},"user_id":"my_user_id","company_id":"my_company_id","session_token":"xcvkrjmcfghwuignrmcmhxdhaaezse4w]s98y18cx98q3yhwmnhcfx43f"}]').map{|element|
      result = EventModel.from_hash(element)
      result.request.time = Time.now.utc.iso8601
      result.response.time = (Time.now.utc + 1).iso8601
      result
    }

    # Perform the API call through the SDK function
    self.class.controller.create_events_batch(body)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end


  # Update Single User via API
  def test_update_user()
    # Parameters for the API call

    metadata = JSON.parse('{'\
      '"email": "testrubyapi@user.com",'\
      '"name": "ruby api user",'\
      '"custom": "testdata"'\
    '}')

    user_model = UserModel.new()
    user_model.modified_time = Time.now.utc.iso8601
    user_model.user_id = "12345"
    user_model.company_id = "67890"
    user_model.metadata = metadata

    # Perform the API call through the SDK function
    self.class.controller.update_user(user_model)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end

  # Add Batched Users via Ingestion API
  def test_update_users_batch()
    # Parameters for the API call

    metadata = JSON.parse('{'\
      '"email": "testrubyapi@user.com",'\
      '"name": "ruby api user",'\
      '"custom": "testdata"'\
    '}')

    user_model_A = UserModel.new()
    user_model_A.modified_time = Time.now.utc.iso8601
    user_model_A.user_id = "12345"
    user_model_A.company_id = "67890"
    user_model_A.metadata = metadata

    user_model_B = UserModel.new()
    user_model_B.modified_time = Time.now.utc.iso8601
    user_model_B.user_id = "1234"
    user_model_B.company_id = "6789"
    user_model_B.metadata = metadata

    users = [user_model_A, user_model_B]

    # Perform the API call through the SDK function
    self.class.controller.update_users_batch(users)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end

  # Get the application configuration
  def test_get_app_config()

    # Perform the API call through the SDK function
    app_config = self.class.controller.get_app_config()

    # Test response code
    assert_equal(@response_catcher.response.status_code, 200)
  end

  # Add Single Company via API
  def test_update_company()
    # Parameters for the API call

    company_model = CompanyModel.new()
    company_model.modified_time = Time.now.utc.iso8601
    company_model.company_id = "12345"

    # Perform the API call through the SDK function
    self.class.controller.update_company(company_model)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end

  # Add Batched Companies via Ingestion API
  def test_update_companies_batch()
    # Parameters for the API call

    company_model_A = CompanyModel.new()
    company_model_A.modified_time = Time.now.utc.iso8601
    company_model_A.company_id = "12345"

    company_model_B = CompanyModel.new()
    company_model_B.modified_time = Time.now.utc.iso8601
    company_model_B.company_id = "67890"
    company_model_B.metadata = JSON.parse('{'\
        '"string_field": "value_1",'\
        '"name": "ruby api user",'\
        '"custom": "testdata"'\
      '}')

    companies = [company_model_A, company_model_B]

    # Perform the API call through the SDK function
    self.class.controller.update_companies_batch(companies)

    # Test response code
    assert_equal(@response_catcher.response.status_code, 201)
  end
end
