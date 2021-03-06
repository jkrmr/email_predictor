module Emails
  class EmailFormat
    class FirstNameDotLastInitial < EmailFormat
      def predict_address_for(email:)
        "#{email.first_name}.#{email.last_initial}@#{email.domain}"
      end
    end
  end
end
