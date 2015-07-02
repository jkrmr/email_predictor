module Emails
  # Decorates Email object with logic to predict email address
  # Each subclass implements a strategy via #predict_email_address_for(email:)
  class EmailFormat
    attr_reader :email

    # detects the format of the passed-in email,
    # initializes a format object for it
    def self.detect_for(email:)
      case email.recipient
      when email.name
        NameDotName.new(email)
      when [email.first_name, email.last_initial]
        NameDotInitial.new(email)
      when [email.first_initial, email.last_name]
        InitialDotName.new(email)
      when [email.first_initial, email.last_initial]
        InitialDotInitial.new(email)
      else
        Unrecognized.new(email)
      end
    end

    def initialize(email)
      @email = email
    end

    def domain
      email.domain
    end

    def predict_address_for(email:)
      fail NotImplementedError, 'must be implemented by subclass'
    end
  end
end
