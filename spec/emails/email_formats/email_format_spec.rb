require 'spec_helper'

module Emails
  describe EmailFormat do
    let(:email) { Email.new('user one', 'user.one@email.com') }
    subject(:format) { EmailFormat.new(email) }

    describe '#domain' do
      it 'delegates to the decorated email' do
        expect(format.domain).to eq email.domain
      end
    end

    describe '#predicted_address_for' do
      it 'raises an error if not overridden by a subclass' do
        partial_email = PartialEmail.new('user two', 'email.com')

        abstract_meth = -> { format.predict_address_for(email: partial_email) }

        expect { abstract_meth.call }.to raise_error(NotImplementedError)
      end
    end
  end
end
