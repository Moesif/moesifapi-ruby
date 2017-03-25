

require 'date'
module MoesifApi
  class EventResponseModel < BaseModel
    # Time when response received
    # @return [DateTime]
    attr_accessor :time

    # HTTP Status code such as 200
    # @return [Integer]
    attr_accessor :status

    # Key/Value map of response headers
    # @return [Object]
    attr_accessor :headers

    # Response body
    # @return [Object]
    attr_accessor :body

    # IP Address from the response, such as the server IP Address
    # @return [String]
    attr_accessor :ip_address

    # Transfer Encoding of body if other than JSON
    # @return [String]
    attr_accessor :transfer_encoding

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["time"] = "time"
        @hash["status"] = "status"
        @hash["headers"] = "headers"
        @hash["body"] = "body"
        @hash["ip_address"] = "ip_address"
        @hash["transfer_encoding"] = "transfer_encoding"
      end
      @hash
    end

    def initialize(time = nil,
                   status = nil,
                   headers = nil,
                   body = nil,
                   ip_address = nil,
                   transfer_encoding = nil)
      @time = time
      @status = status
      @headers = headers
      @body = body
      @ip_address = ip_address
      @transfer_encoding = transfer_encoding
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        time = DateTime.iso8601(hash["time"]) if hash["time"]
        status = hash["status"]
        headers = hash["headers"]
        body = hash["body"]
        ip_address = hash["ip_address"]
        transfer_encoding = hash["transfer_encoding"]

        # Create object from extracted values
        EventResponseModel.new(time,
                               status,
                               headers,
                               body,
                               ip_address,
                               transfer_encoding)
      end
    end
  end
end
