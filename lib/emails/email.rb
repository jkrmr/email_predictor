module Emails
  class Email
    attr_reader :name, :first_name, :last_name, :first_initial, :last_initial,
      :email, :username, :domain

    def self.collection_from(email_collection)
      email_collection.map { |name, email| new(name, email) }
    end

    # @param name [String] person's name
    # @param email [String] person's email address
    def initialize(name, email)
      parse_name(name)
      parse_email_address(email)
    end

    def format
      {
        [first_name, last_name]       => 'FirstNameDotLastName',
        [first_name, last_initial]    => 'FirstNameDotLastInitial',
        [first_initial, last_name]    => 'FirstInitialDotLastName',
        [first_initial, last_initial] => 'FirstInitialDotLastInitial',
        [last_initial, first_name]    => 'LastInitialDotFirstName',
        [last_name, first_initial]    => 'LastNameDotFirstInitial',
        [last_initial, first_initial] => 'LastInitialDotFirstInitial',
        [last_name, first_name]       => 'LastNameDotFirstName'
      }.fetch(username, 'Unrecognized')
    end

    private

    # parses a name string into first and last name,
    # and first and last initial
    # @param name_str [String] e.g. "Chesty Puller"
    def parse_name(name_str)
      @name          = name_str.downcase.split
      @first_name    = name.first
      @last_name     = name.last
      @first_initial = first_name[0]
      @last_initial  = last_name[0]
    end

    # parses an email address into its constituent parts,
    # the mailbox and domain. The mailbox is assumed to be a comma-separated
    # username, and this is parsed into a string tuple and referred to by
    # Email#username.
    # @param email [String] e.g. "c.puller@firstofseventh.usmc.mil"
    def parse_email_address(email)
      @email           = email.downcase
      mailbox, @domain = email.split('@')
      @username        = mailbox.split('.')
    end
  end
end
