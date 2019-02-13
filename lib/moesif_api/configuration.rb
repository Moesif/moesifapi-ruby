

module MoesifApi
  class Configuration
    # The base Uri for API calls
    @base_uri = 'https://api.moesif.net'

    # Your Application Id for authentication/authorization
    @application_id = 'SET_ME'

    @version = '1.2.4'

    # create the getters and setters
    class << self
      attr_accessor :base_uri
      attr_accessor :application_id
      attr_accessor :version
    end
  end
end
