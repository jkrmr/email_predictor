module Emails
  class EmailFormat
    class LastNameDotFirstName < EmailFormat
      def predict_address_for(email:)
        "#{email.last_name}.#{email.first_name}@#{email.domain}"
      end
    end
  end
end
