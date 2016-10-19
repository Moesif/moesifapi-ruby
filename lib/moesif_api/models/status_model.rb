

module MoesifApi
  class StatusModel < BaseModel
    # Status of Call
    # @return [Boolean]
    attr_accessor :status

    # Location
    # @return [String]
    attr_accessor :region

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["status"] = "status"
        @hash["region"] = "region"
      end
      @hash
    end

    def initialize(status = nil,
                   region = nil)
      @status = status
      @region = region
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        status = hash["status"]
        region = hash["region"]

        # Create object from extracted values
        StatusModel.new(status,
                              region)
      end
    end
  end
end
