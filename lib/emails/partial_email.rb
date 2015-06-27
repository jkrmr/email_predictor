module Emails
  class PartialEmail < Email
    def initialize(name, domain)
      parse_name(name)
      @domain = domain.downcase
    end
  end
end
