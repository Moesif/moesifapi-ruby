

require 'date'
module MoesifApi
  class CompanyModel < BaseModel

    # company id of the company
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

    # Optionally tag the company with the company domain.
    # @return [String]
    attr_accessor :company_domain

    # meta data
    # @return [Object]
    attr_accessor :metadata

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["company_id"] = "company_id"
        @hash["modified_time"] = "modified_time"
        @hash["ip_address"] = "ip_address"
        @hash["session_token"] = "session_token"
        @hash["company_domain"] = "company_domain"
        @hash["metadata"] = "metadata"
      end
      @hash
    end

    def initialize(company_id = nil,
                   modified_time = nil,
                   ip_address = nil,
                   session_token = nil,
                   company_domain = nil,
                   metadata = nil)
      @company_id = company_id
      @modified_time = modified_time
      @ip_address = ip_address
      @session_token = session_token
      @company_domain = company_domain
      @metadata = metadata
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        company_id = hash["company_id"]
        modified_time = DateTime.iso8601(hash["modified_time"]) if hash["modified_time"]
        ip_address = hash["ip_address"]
        session_token = hash["session_token"]
        company_domain = hash["company_domain"]
        metadata = hash["metadata"]

        # Create object from extracted values
        CompanyModel.new(company_id,
                      modified_time,
                      ip_address,
                      session_token,
                      company_domain,
                      metadata)
      end
    end
  end
end
