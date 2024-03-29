

module MoesifApi
  class Configuration
    # The base Uri for API calls
    @base_uri = 'https://api.moesif.net'

    # Your Application Id for authentication/authorization
    @application_id = 'SET_ME'

    @version = '2.0.2'

    @user_agent = "moesifapi-ruby/2.0.2"

    # create the getters and setters
    class << self
      attr_accessor :base_uri
      attr_accessor :application_id
      attr_accessor :version
      attr_accessor :user_agent
    end
  end
end
