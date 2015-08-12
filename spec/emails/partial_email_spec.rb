require 'spec_helper'

module Emails
  describe PartialEmail do
    subject(:email) { PartialEmail.new('user name', 'example.com') }

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

        expect(username).to be_nil
      end
    end

    describe '#domain' do
      it "returns the email recipient's email domain" do
        domain = email.domain

        expect(domain).to eq 'example.com'
      end
    end
  end
end
