

require 'date'
module MoesifApi
  class UserModel < BaseModel

    # user id of the user
    # @return [String]
    attr_accessor :user_id

    # company id associated with the user if avaialble.
    # @return [String]
    attr_accessor :company_id

    # Time when modification was made. default to current time on server side.
    # @return [DateTime]
    attr_accessor :modified_time

    # ip address associated with user if avaialble.
    # @return [String]
    attr_accessor :ip_address

    # session token associated with user if avaialble.
    # @return [String]
    attr_accessor :session_token

    # Optionally tag the user with an user agent.
    # @return [String]
    attr_accessor :user_agent_string

    # meta data
    # @return [Object]
    attr_accessor :metadata

    # campaign object
    # @return [CampaignModel]
    attr_accessor :campaign

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["user_id"] = "user_id"
        @hash["company_id"] = "company_id"
        @hash["modified_time"] = "modified_time"
        @hash["ip_address"] = "ip_address"
        @hash["session_token"] = "session_token"
        @hash["user_agent_string"] = "user_agent_string"
        @hash["metadata"] = "metadata"
        @hash["campaign"] = "campaign"
      end
      @hash
    end

    def initialize(user_id = nil,
                   company_id = nil,
                   modified_time = nil,
                   ip_address = nil,
                   session_token = nil,
                   user_agent_string = nil,
                   metadata = nil,
                   campaign = nil)
      @user_id = user_id
      @company_id = company_id
      @modified_time = modified_time
      @ip_address = ip_address
      @session_token = session_token
      @user_agent_string = user_agent_string
      @metadata = metadata
      @campaign = campaign
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        user_id = hash["user_id"]
        company_id = hash["company_id"]
        modified_time = DateTime.iso8601(hash["modified_time"]) if hash["modified_time"]
        ip_address = hash["ip_address"]
        session_token = hash["session_token"]
        user_agent_string = hash["user_agent_string"]
        metadata = hash["metadata"]
        campaign = CampaignModel.from_hash(hash["campaign"]) if hash["campaign"]

        # Create object from extracted values
        UserModel.new(user_id,
                      company_id,
                      modified_time,
                      ip_address,
                      session_token,
                      user_agent_string,
                      metadata,
                      campaign)
      end
    end
  end
end
