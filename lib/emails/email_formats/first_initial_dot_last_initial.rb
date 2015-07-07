module Emails
  class EmailFormat
    class FirstInitialDotLastInitial < EmailFormat
      def predict_address_for(email:)
        "#{email.first_initial}.#{email.last_initial}@#{email.domain}"
      end
    end
  end
end
