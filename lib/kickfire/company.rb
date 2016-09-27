module Kickfire
  class Company
    BASE_URL = "https://api.kickfire.com/v2/"
    BASE_QUERY = "company:(all)"

    def initialize(attributes = nil)
      if attributes.kind_of?(Array) && attributes.first
        @raw = attributes.first
        attributes.first.each do |k,v|
          instance_variable_set("@#{k.underscore}", v)
        end
      elsif attributes.kind_of? String
        @ip = attributes
      end
    end

    def self.find(ip, api_key: nil)
      if !api_key
        if defined? Kickfire::API_KEY
          api_key = Kickfire::API_KEY
        end
      end

      response = HTTParty.get("#{BASE_URL}#{BASE_QUERY}?#{URI.encode_www_form({ip: ip, key: api_key})}")

      if !response
        raise Kickfire::Error.new('No data returned from Kickfire')
      elsif response['status'] == 'error'
        Kickfire::Error.find(response['code'],response['message'])
      elsif response['status'] == 'not found'
        nil
      else
        new(response['data'])
      end
    end

    attr_reader :cid
    attr_reader :name
    attr_reader :website
    attr_reader :street
    attr_reader :city
    attr_reader :regionShort
    attr_reader :region
    attr_reader :postal
    attr_reader :countryShort
    attr_reader :country
    attr_reader :phone
    attr_reader :employees
    attr_reader :revenue
    attr_reader :category
    attr_reader :site_code
    attr_reader :category2
    attr_reader :naics_code
    attr_reader :longitude
    attr_reader :lattitude
    attr_reader :stock_symbol
    attr_reader :facebook
    attr_reader :twitter
    attr_reader :linkedin
    attr_reader :linedkin_id

    def isp?
      @is_i_s_p == 1
    end

    def twitter_url
      "http://twitter.com/" + twitter
    end

    def address
      [street, city, regionShort, postal].compact.join ", "
    end

    def to_json
      @raw.to_json
    end
  end
end
