module Emails
  class EmailFormat
    class LastInitialDotFirstInitial < EmailFormat
      def predict_address_for(email:)
        "#{email.last_initial}.#{email.first_initial}@#{email.domain}"
      end
    end
  end
end
