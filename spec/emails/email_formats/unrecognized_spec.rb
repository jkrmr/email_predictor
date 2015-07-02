require 'spec_helper'

module Emails
  class EmailFormat
    describe Unrecognized do
      let(:email) { Email.new('user one', 'user.one@email.com') }
      subject(:format) { Unrecognized.new(email) }

      describe '#domain' do
        it 'delegates to the decorated email' do
          expect(format.domain).to eq email.domain
        end
      end

      describe '#predicted_address_for' do
        it 'generates a best guess (name.name) for an unrecognized format' do
          partial_email = PartialEmail.new('user two', 'email.com')

          generated_email = format.predict_address_for(email: partial_email)
          message = 'Unrecognized format. Best guess: user.two@email.com'

          expect(generated_email).to eq message
        end
      end
    end
  end
end
