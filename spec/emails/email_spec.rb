require 'spec_helper'

module Emails
  describe Email do
    subject(:email) { Email.new('user name', 'user.name@example.com') }

    describe '#first_initial' do
      it "returns the email recipient's first initial" do
        first_initial = email.first_initial

        expect(first_initial).to eq 'u'
      end
    end

    describe '#last_initial' do
      it "returns the email recipient's last initial" do
        last_initial = email.last_initial

        expect(last_initial).to eq 'n'
      end
    end

    describe '#username' do
      it "returns the email recipient's email username" do
        username = email.username

        expect(username).to eq %w(user name)
      end
    end

    describe '#domain' do
      it "returns the email recipient's email domain" do
        domain = email.domain

        expect(domain).to eq 'example.com'
      end
    end

    describe '::collection_from' do
      it 'returns an array of email objects' do
        emails = Email.collection_from(sample_data)

        expect(emails).to be_an_array_of(Email)
      end
    end

    def sample_data
      {
        'user 1' => 'user.1@ex.com',
        'user 2' => 'user.2@ex.com'
      }
    end
  end
end
