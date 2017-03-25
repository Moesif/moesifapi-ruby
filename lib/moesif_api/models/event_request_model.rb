

require 'date'
module MoesifApi
  class EventRequestModel < BaseModel
    # Time when request was made
    # @return [DateTime]
    attr_accessor :time

    # full uri of request such as https://www.example.com/my_path?param=1
    # @return [String]
    attr_accessor :uri

    # verb of the API request such as GET or POST
    # @return [String]
    attr_accessor :verb

    # Key/Value map of request headers
    # @return [Object]
    attr_accessor :headers

    # Optionally tag the call with your API or App version
    # @return [String]
    attr_accessor :api_version

    # IP Address of the client if known.
    # @return [String]
    attr_accessor :ip_address

    # Request body
    # @return [Object]
    attr_accessor :body

    # Transfer Encoding of body if other than JSON
    # @return [String]
    attr_accessor :transfer_encoding

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["time"] = "time"
        @hash["uri"] = "uri"
        @hash["verb"] = "verb"
        @hash["headers"] = "headers"
        @hash["api_version"] = "api_version"
        @hash["ip_address"] = "ip_address"
        @hash["body"] = "body"
        @hash["transfer_encoding"] = "transfer_encoding"
      end
      @hash
    end

    def initialize(time = nil,
                   uri = nil,
                   verb = nil,
                   headers = nil,
                   api_version = nil,
                   ip_address = nil,
                   body = nil,
                   transfer_encoding = nil)
      @time = time
      @uri = uri
      @verb = verb
      @headers = headers
      @api_version = api_version
      @ip_address = ip_address
      @body = body
      @transfer_encoding = transfer_encoding
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        time = DateTime.iso8601(hash["time"]) if hash["time"]
        uri = hash["uri"]
        verb = hash["verb"]
        headers = hash["headers"]
        api_version = hash["api_version"]
        ip_address = hash["ip_address"]
        body = hash["body"]
        transfer_encoding = hash["transfer_encoding"]

        # Create object from extracted values
        EventRequestModel.new(time,
                              uri,
                              verb,
                              headers,
                              api_version,
                              ip_address,
                              body,
                              transfer_encoding)
      end
    end
  end
end
