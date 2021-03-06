module Emails
  class EmailFormat
    class FirstNameDotLastName < EmailFormat
      def predict_address_for(email:)
        "#{email.first_name}.#{email.last_name}@#{email.domain}"
      end
    end
  end
end
