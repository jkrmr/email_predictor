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

    describe '::detect_for' do
      it 'correctly detects last inital first name emails' do
        email = Email.new('Eric Cartman', 'c.eric@southpark.com')

        format = EmailFormat.detect_for(email: email)

        expect(format).to be_an_instance_of Emails::EmailFormat::LastInitialDotFirstName
      end

      it 'correctly detects last name first initial emails' do
        email = Email.new('Eric Cartman', 'cartman.e@southpark.com')

        format = EmailFormat.detect_for(email: email)

        expect(format).to be_an_instance_of Emails::EmailFormat::LastNameDotFirstInitial
      end

      it 'correctly detects last name first name emails' do
        email = Email.new('Eric Cartman', 'cartman.eric@southpark.com')

        format = EmailFormat.detect_for(email: email)

        expect(format).to be_an_instance_of Emails::EmailFormat::LastNameDotFirstName
      end

      it 'correctly detects last initial first initial emails' do
        email = Email.new('Eric Cartman', 'c.e@southpark.com')

        format = EmailFormat.detect_for(email: email)

        expect(format).to be_an_instance_of Emails::EmailFormat::LastInitialDotFirstInitial
      end
    end
  end
end
