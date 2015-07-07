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
        FirstNameDotLastName.new(email)
      when [email.first_name, email.last_initial]
        FirstNameDotLastInitial.new(email)
      when [email.first_initial, email.last_name]
        FirstInitialDotLastName.new(email)
      when [email.first_initial, email.last_initial]
        FirstInitialDotLastInitial.new(email)
      when [email.last_initial, email.first_name]
        LastInitialDotFirstName.new(email)
      when [email.last_name, email.first_initial]
        LastNameDotFirstInitial.new(email)
      when [email.last_initial, email.first_initial]
        LastInitialDotFirstInitial.new(email)
      when [email.last_name, email.first_name]
        LastNameDotFirstName.new(email)
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
