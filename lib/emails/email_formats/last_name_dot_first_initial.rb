module Emails
  class EmailFormat
    class LastNameDotFirstInitial < EmailFormat
      def predict_address_for(email:)
        "#{email.last_name}.#{email.first_initial}@#{email.domain}"
      end
    end
  end
end
