

require 'date'
module MoesifApi
  class UserModel < BaseModel
    # Time when request was made
    # @return [DateTime]
    attr_accessor :modified_time

    # session token associated with user if avaialble.
    # @return [String]
    attr_accessor :session_token

    # verb of the API request su
    # @return [String]
    attr_accessor :user_id

    # Optionally tag the user with an user agent.
    # @return [String]
    attr_accessor :user_agent_string

    # meta data
    # @return [Object]
    attr_accessor :metadata

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["modified_time"] = "modified_time"
        @hash["session_token"] = "session_token"
        @hash["user_id"] = "user_id"
        @hash["user_agent_string"] = "user_agent_string"
        @hash["metadata"] = "metadata"
      end
      @hash
    end

    def initialize(modified_time = nil,
                   session_token = nil,
                   user_id = nil,
                   user_agent_string = nil,
                   metadata = nil)
      @modified_time = modified_time
      @session_token = session_token
      @user_id = user_id
      @user_agent_string = user_agent_string
      @metadata = metadata
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        modified_time = DateTime.iso8601(hash["modified_time"]) if hash["modified_time"]
        session_token = hash["session_token"]
        user_id = hash["user_id"]
        user_agent_string = hash["user_agent_string"]
        metadata = hash["metadata"]

        # Create object from extracted values
        UserModel.new(modified_time,
                      session_token,
                      user_id,
                      user_agent_string,
                      metadata)
      end
    end
  end
end
