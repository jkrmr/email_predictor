require 'spec_helper'

module Emails
  class EmailFormat
    describe FirstNameDotLastInitial do
      let(:email) { Email.new('user one', 'user.one@email.com') }
      subject(:format) { FirstNameDotLastInitial.new(email) }

      describe '#domain' do
        it 'delegates to the decorated email' do
          expect(format.domain).to eq email.domain
        end
      end

      describe '#predicted_address_for' do
        it 'generates an appropriate formatted predicted email' do
          partial_email = PartialEmail.new('user two', 'email.com')

          generated_email = format.predict_address_for(email: partial_email)

          expect(generated_email).to eq 'user.t@email.com'
        end
      end
    end
  end
end
