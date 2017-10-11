

module MoesifApi
  class EventModel < BaseModel
    # API request object
    # @return [EventRequestModel]
    attr_accessor :request

    # API response Object
    # @return [EventResponseModel]
    attr_accessor :response

    # End user's auth/session token
    # @return [String]
    attr_accessor :session_token

    # comma separated list of tags, see documentation
    # @return [String]
    attr_accessor :tags

    # End user's user_id string from your app
    # @return [String]
    attr_accessor :user_id

    # metadata
    # @return [Object]
    attr_accessor :metadata

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["request"] = "request"
        @hash["response"] = "response"
        @hash["session_token"] = "session_token"
        @hash["tags"] = "tags"
        @hash["user_id"] = "user_id"
        @hash["metadata"] = "metadata"
      end
      @hash
    end

    def initialize(request = nil,
                   response = nil,
                   session_token = nil,
                   tags = nil,
                   user_id = nil,
                   metadata = nil)
      @request = request
      @response = response
      @session_token = session_token
      @tags = tags
      @user_id = user_id
      @metadata = metadata
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        request = EventRequestModel.from_hash(hash["request"]) if hash["request"]
        response = EventResponseModel.from_hash(hash["response"]) if hash["response"]
        session_token = hash["session_token"]
        tags = hash["tags"]
        user_id = hash["user_id"]
        metadata = hash["metadata"]

        # Create object from extracted values
        EventModel.new(request,
                             response,
                             session_token,
                             tags,
                             user_id,
                             metadata)
      end
    end
  end
end
