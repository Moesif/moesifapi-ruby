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

    # company_id string
    # @return [String]
    attr_accessor :company_id

    # metadata
    # @return [Hash]
    attr_accessor :metadata

    # direction string
    # @return [String]
    attr_accessor :direction

    # Weight of an API call
    # @return [Integer]
    attr_accessor :weight

    # Blocked by in case of governance rule of an API call
    # @return [Integer]
    attr_accessor :blocked_by

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash['request'] = 'request'
        @hash['response'] = 'response'
        @hash['session_token'] = 'session_token'
        @hash['tags'] = 'tags'
        @hash['user_id'] = 'user_id'
        @hash['company_id'] = 'company_id'
        @hash['metadata'] = 'metadata'
        @hash['direction'] = 'direction'
        @hash['weight'] = 'weight'
        @hash['blocked_by'] = 'blocked_by'
      end
      @hash
    end

    def initialize(request = nil,
                   response = nil,
                   session_token = nil,
                   tags = nil,
                   user_id = nil,
                   company_id = nil,
                   metadata = nil,
                   direction = nil,
                   weight = nil,
                   blocked_by = nil,
                  )
      @request = request
      @response = response
      @session_token = session_token
      @tags = tags
      @user_id = user_id
      @company_id = company_id
      @metadata = metadata
      @direction = direction
      @weight = weight
      @blocked_by = blocked_by
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash.nil?
        nil
      else
        # Extract variables from the hash
        request = EventRequestModel.from_hash(hash['request']) if hash['request']
        response = EventResponseModel.from_hash(hash['response']) if hash['response']
        session_token = hash['session_token']
        tags = hash['tags']
        user_id = hash['user_id']
        company_id = hash['company_id']
        metadata = hash['metadata']
        direction = hash['direction']
        weight = hash['weight']
        blocked_by = hash['blocked_by']

        # Create object from extracted values
        EventModel.new(request,
                       response,
                       session_token,
                       tags,
                       user_id,
                       company_id,
                       metadata,
                       direction,
                       weight,
                       blocked_by
                      )
      end
    end
  end
end
