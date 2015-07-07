module Emails
  class EmailFormat
    class Unrecognized < EmailFormat
      def predict_address_for(email:)
        best_guess = FirstNameDotLastName.new(self.email)
        predicted = best_guess.predict_address_for(email: email)

        "Unrecognized format. Best guess: #{predicted}"
      end
    end
  end
end
