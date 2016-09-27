module Kickfire
  class Error < StandardError
    def self.find(code,message)
      if  code.to_s.index("90")
        raise Kickfire::AuthenticationError.new("#{code} #{message}")
      elsif code.to_s.index("10")
        raise Kickfire::AccountLimitError.new("#{code} #{message}")
      elsif code.to_s.index("20") || code.to_s.index("20")
        raise Kickfire::RequestError.new("#{code} #{message}")
      else
        raise Kickfire::Error.new("#{code} #{message}")
      end
    end
  end
  class AuthenticationError < Error
  end
  class AccountLimitError < Error
  end
  class RequestError < Error
  end
end
