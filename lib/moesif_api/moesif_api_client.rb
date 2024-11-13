

module MoesifApi
  class MoesifAPIClient
    # Singleton access to api controller
    # @return [ApiController] Returns the controller instance
    def api
      ApiController.instance
    end

    # Singleton access to health controller
    # @return [HealthController] Returns the controller instance
    def health
      HealthController.instance
    end

    # Initializer with authentication and configuration parameters
    def initialize(application_id, user_agent=nil, retry_ccount=5)
      Configuration.application_id = application_id
      Configuration.retry_ccount = retry_count
      unless user_agent.nil?
        Configuration.user_agent = user_agent
      end
    end
  end
end
