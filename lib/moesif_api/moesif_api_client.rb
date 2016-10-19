

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
    def initialize(application_id)
      Configuration.application_id = application_id
    end
  end
end
