# MoesifApi Lib for Ruby

[![Built For rack][ico-built-for]][link-built-for]
[![Latest Version][ico-version]][link-package]
[![Total Downloads][ico-downloads]][link-downloads]
[![Software License][ico-license]][link-license]
[![Source Code][ico-source]][link-source]

[Source Code on GitHub](https://github.com/moesif/moesifapi-ruby)

__Check out Moesif's [Developer Documentation](https://www.moesif.com/docs) and [Ruby API Reference](https://www.moesif.com/docs/api?ruby) to learn more__


## How to configure:

The generated code might need to be configured with your API credentials. To do that,
open the file "configuration.rb" and edit it's contents.

Alternatively, you can modify the Configuration parameters at run-time through the following:
```
MoesifApi::Configuration.your_paramater = YOUR_VALUE
```
### Install from RubyGems

```
gem install moesif_api
```

## How to use:

After having installed the gem, you can easily use the SDK following these steps.

Your Moesif Application Id can be found in the [_Moesif Portal_](https://www.moesif.com/).
After signing up for a Moesif account, your Moesif Application Id will be displayed during the onboarding steps. 

You can always find your Moesif Application Id at any time by logging 
into the [_Moesif Portal_](https://www.moesif.com/), click on the top right menu,
and then clicking _Installation_.

### Create Event

```ruby
require 'moesif_api'

api_client = MoesifApi::MoesifAPIClient.new(my_application_id)
api_controller = api_client.api

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
  '"Date": "Tue, 20 Aug 2019 23:46:49 GMT",'\
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
event_req.time = "2019-09-09T04:45:42.914"
event_req.uri = "https://api.acmeinc.com/items/reviews/"
event_req.verb = "PATCH"
event_req.api_version = "1.1.0"
event_req.ip_address = "61.48.220.123"
event_req.headers = req_headers
event_req.body = req_body

event_rsp = EventResponseModel.new()
event_rsp.time = "2019-09-09T04:45:42.914"
event_rsp.status = 500
event_rsp.headers = rsp_headers
event_rsp.body = rsp_body

event_model = EventModel.new()
event_model.request = event_req
event_model.response = event_rsp
event_model.user_id ="my_user_id"
event_model.company_id = "my_company_id"
event_model.session_token = "23jdf0owekfmcn4u3qypxg09w4d8ayrcdx8nu2ng]s98y18cx98q3yhwmnhcfx43f"
event_model.metadata = metadata

# Perform the API call through the SDK function
response = api_controller.create_event(event_model)
```

## Update a Single User

Create or update a user profile in Moesif.
The metadata field can be any customer demographic or other info you want to store.
Only the `userId` field is required.
For details, visit the [Ruby API Reference](https://www.moesif.com/docs/api?ruby#update-a-user).

```ruby
api_client = MoesifApi::MoesifAPIClient.new('YOUR_COLLECTOR_APPLICATION_ID').api

metadata => {
  :email => 'john@acmeinc.com',
  :first_name => 'John',
  :last_name => 'Doe',
  :title => 'Software Engineer',
  :salesInfo => {
      :stage => 'Customer',
      :lifetime_value => 24000,
      :accountOwner => 'mary@contoso.com',
  }
}

# Campaign object is optional, but useful if you want to track ROI of acquisition channels
# See https://www.moesif.com/docs/api#users for campaign schema
campaign = CampaignModel.new()
campaign.utm_source = "google"
campaign.utm_medium = "cpc"
campaign.utm_campaign = "adwords"
campaign.utm_term = "api+tooling"
campaign.utm_content = "landing"

# Only user_id is required.
# metadata can be any custom object
user = UserModel.new()
user.user_id = "12345"
user.company_id = "67890" # If set, associate user with a company object
user.campaign = campaign
user.metadata = metadata

update_user = api_client.update_user(user)
```

## Update Users in Batch

Similar to UpdateUser, but used to update a list of users in one batch. 
Only the `userId` field is required.
For details, visit the [Ruby API Reference](https://www.moesif.com/docs/api?ruby#update-users-in-batch).

```ruby
api_client = MoesifApi::MoesifAPIClient.new('YOUR_COLLECTOR_APPLICATION_ID').api

users = []

metadata => {
  :email => 'john@acmeinc.com',
  :first_name => 'John',
  :last_name => 'Doe',
  :title => 'Software Engineer',
  :salesInfo => {
      :stage => 'Customer',
      :lifetime_value => 24000,
      :accountOwner => 'mary@contoso.com',
  }
}

# Campaign object is optional, but useful if you want to track ROI of acquisition channels
# See https://www.moesif.com/docs/api#users for campaign schema
campaign = CampaignModel.new()
campaign.utm_source = "google"
campaign.utm_medium = "cpc"
campaign.utm_campaign = "adwords"
campaign.utm_term = "api+tooling"
campaign.utm_content = "landing"

# Only user_id is required.
# metadata can be any custom object
user = UserModel.new()
user.user_id = "12345"
user.company_id = "67890" # If set, associate user with a company object
user.campaign = campaign
user.metadata = metadata

users << user

api_client = api_controller.update_users_batch(user_model)
```

## Update a Single Company

Create or update a company profile in Moesif.
The metadata field can be any company demographic or other info you want to store.
Only the `companyId` field is required.
For details, visit the [Ruby API Reference](https://www.moesif.com/docs/api?ruby#update-a-company).

```ruby
api_client = MoesifApi::MoesifAPIClient.new('YOUR_COLLECTOR_APPLICATION_ID').api

metadata => {
  :org_name => 'Acme, Inc',
  :plan_name => 'Free',
  :deal_stage => 'Lead',
  :mrr => 24000,
  :demographics => {
      :alexa_ranking => 500000,
      :employee_count => 47
  }
}

# Campaign object is optional, but useful if you want to track ROI of acquisition channels
# See https://www.moesif.com/docs/api#update-a-company for campaign schema
campaign = CampaignModel.new()
campaign.utm_source = "google"
campaign.utm_medium = "cpc"
campaign.utm_campaign = "adwords"
campaign.utm_term = "api+tooling"
campaign.utm_content = "landing"

# Only company_id is required.
# metadata can be any custom object
company = CompanyModel.new()
company.company_id = "67890"
company.company_domain = "acmeinc.com" # If domain is set, Moesif will enrich your profiles with publicly available info 
company.campaign = campaign
company.metadata = metadata

update_company = api_client.update_company(company)
```


## Update Companies in Batch

Similar to updateCompany, but used to update a list of companies in one batch. 
Only the `companyId` field is required.
For details, visit the [Ruby API Reference](https://www.moesif.com/docs/api?ruby#update-companies-in-batch).

```ruby
api_client = MoesifApi::MoesifAPIClient.new('YOUR_COLLECTOR_APPLICATION_ID').api

companies = []

metadata => {
  :org_name => 'Acme, Inc',
  :plan_name => 'Free',
  :deal_stage => 'Lead',
  :mrr => 24000,
  :demographics => {
      :alexa_ranking => 500000,
      :employee_count => 47
  }
}

# Campaign object is optional, but useful if you want to track ROI of acquisition channels
# See https://www.moesif.com/docs/api#update-a-company for campaign schema
campaign = CampaignModel.new()
campaign.utm_source = "google"
campaign.utm_medium = "cpc"
campaign.utm_campaign = "adwords"
campaign.utm_term = "api+tooling"
campaign.utm_content = "landing"

# Only company_id is required.
# metadata can be any custom object
company = CompanyModel.new()
company.company_id = "67890"
company.company_domain = "acmeinc.com" # If domain is set, Moesif will enrich your profiles with publicly available info 
company.campaign = campaign
company.metadata = metadata

companies << company

update_company = api_client.update_companies(companies)
```

## How to build and install manually:

The generated code depends on a few Ruby gems. The references to these gems are
added in the gemspec file. The easiest way to resolve the dependencies,
build the gem and install it is through Rake:

  1. Install Rake if not already installed: `gem install rake`
  2. Install Bundler if not already installed: `gem install bundler`
  3. From terminal/cmd navigate to the root directory of the SDK.
  4. Invoke: `rake install`

Alternatively, you can build and install the gem manually:

  1. From terminal/cmd navigate to the root directory of the SDK.
  2. Run the build command: `gem build moesif_api.gemspec`
  3. Run the install command: `gem install ./moesif_api-1.0.0.gem`

Note: You will need to have internet access for this step.

## How  to test:

You can test the generated SDK and the server with automatically generated test
cases as follows:

  1. Add your Moesif application id to 'test/controllers/controller_test_base'. You can find your Application Id from [_Moesif Dashboard_](https://www.moesif.com/) -> _Top Right Menu_ -> _Installation_
  2. From terminal/cmd navigate to the root directory of the SDK.
  3. Invoke: `bundle exec rake`

  [ico-built-for]: https://img.shields.io/badge/built%20for-rack-blue.svg
[ico-version]: https://img.shields.io/gem/v/moesif_api.svg
[ico-downloads]: https://img.shields.io/gem/dt/moesif_api.svg
[ico-license]: https://img.shields.io/badge/License-Apache%202.0-green.svg
[ico-source]: https://img.shields.io/github/last-commit/moesif/moesifapi-ruby.svg?style=social

[link-built-for]: https://www.ruby-lang.org
[link-package]: https://rubygems.org/gems/moesif_api
[link-downloads]: https://rubygems.org/gems/moesif_api
[link-license]: https://raw.githubusercontent.com/Moesif/moesifapi-ruby/master/LICENSE
[link-source]: https://github.com/moesif/moesifapi-ruby
