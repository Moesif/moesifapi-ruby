
module MoesifApi
  class CampaignModel < BaseModel

    # the utm source
    # @return [String]
    attr_accessor :utm_source

    # the utm medium
    # @return [String]
    attr_accessor :utm_medium

    # the utm campaign
    # @return [String]
    attr_accessor :utm_campaign

    # the utm term
    # @return [String]
    attr_accessor :utm_term

    # the utm content
    # @return [String]
    attr_accessor :utm_content

    # the referrer
    # @return [String]
    attr_accessor :referrer

    # the referring domain
    # @return [String]
    attr_accessor :referring_domain

    # the gclid
    # @return [String]
    attr_accessor :gclid

    # A mapping from model property names to API property names
    def self.names
      if @hash.nil?
        @hash = {}
        @hash["utm_source"] = "utm_source"
        @hash["utm_medium"] = "utm_medium"
        @hash["utm_campaign"] = "utm_campaign"
        @hash["utm_term"] = "utm_term"
        @hash["utm_content"] = "utm_content"
        @hash["referrer"] = "referrer"
        @hash["referring_domain"] = "referring_domain"
        @hash["gclid"] = "gclid"
      end
      @hash
    end

    def initialize(utm_source = nil,
            utm_medium = nil,
            utm_campaign = nil,
            utm_term = nil,
            utm_content = nil,
            referrer = nil,
            referring_domain = nil,
            gclid = nil)
      @utm_source = utm_source
      @utm_medium = utm_medium
      @utm_campaign = utm_campaign
      @utm_term = utm_term
      @utm_content = utm_content
      @referrer = referrer
      @referring_domain = referring_domain
      @gclid = gclid
    end

    # Creates an instance of the object from a hash
    def self.from_hash(hash)
      if hash == nil
        nil
      else
        # Extract variables from the hash
        utm_source = hash["utm_source"]
        utm_medium = hash["utm_medium"]
        utm_campaign = hash["utm_campaign"]
        utm_term = hash["utm_term"]
        utm_content = hash["utm_content"]
        referrer = hash["referrer"]
        referring_domain = hash["referring_domain"]
        gclid = hash["gclid"]

        # Create object from extracted values
        CampaignModel.new(utm_source,
                        utm_medium,
                        utm_campaign,
                        utm_term,
                        utm_content,
                        referrer,
                        referring_domain,
                        gclid)
      end
    end
  end
end
