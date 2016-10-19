

module MoesifApi
  class Configuration
    # The base Uri for API calls
    @base_uri = 'https://api.moesif.net'

    # Your Application Id for authentication/authorization
    @application_id = 'TODO: Replace'

    # create the getters and setters
    class << self
      attr_accessor :base_uri
      attr_accessor :application_id
    end
  end
end
