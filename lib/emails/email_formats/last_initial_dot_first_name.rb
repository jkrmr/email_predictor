module Emails
  class EmailFormat
    class LastInitialDotFirstName < EmailFormat
      def predict_address_for(email:)
        "#{email.last_initial}.#{email.first_name}@#{email.domain}"
      end
    end
  end
end
