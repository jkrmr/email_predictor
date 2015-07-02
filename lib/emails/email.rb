module Emails
  class Email
    attr_reader :name, :first_name, :last_name, :email, :recipient, :domain

    def self.collection_from(email_collection)
      email_collection.map { |name, email| new(name, email) }
    end

    # name: string recipient's name
    # email: string recipient's email address
    def initialize(name, email)
      parse_name(name)
      parse_email_address(email)
    end

    def first_initial
      @first_initial ||= first_name[0]
    end

    def last_initial
      @last_initial ||= last_name[0]
    end

    private

    def parse_name(name_str)
      @name       = name_str.downcase.split
      @first_name = name.first
      @last_name  = name.last
    end

    def parse_email_address(email)
      @email           = email.downcase
      address, @domain = email.split('@')
      @recipient       = address.split('.')
    end
  end
end
