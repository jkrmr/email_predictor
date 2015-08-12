module Emails
  # Decorates Email object with logic to predict email address
  # Each subclass implements a strategy via #predict_email_address_for(email:)
  class EmailFormat
    attr_reader :email

    # detects the format of the passed-in email,
    # initializes a format object for it
    def self.detect_for(email:)
      format = const_get("Emails::EmailFormat::#{email.format}")
      format.new(email)
    end

    def domain
      email.domain
    end

    protected

    def initialize(email)
      @email = email
    end
  end
end
