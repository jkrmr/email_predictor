module Emails
  class EmailFormat
    class InitialDotName < EmailFormat
      def predict_address_for(email:)
        "#{email.first_initial}.#{email.last_name}@#{email.domain}"
      end
    end
  end
end
