module EmailPredictor
  class Analyzer
    include Emails

    attr_reader :analyzed_data

    def initialize(training_set:)
      @analyzed_data = classify_data(training_set)
    end

    # Generates an email address for a PartialEmail in adherence to the most
    # commonly found EmailFormat for the given email domain.
    #
    # If no data is available for the requested domain, returns a notice to that
    # effect.
    #
    # @param name [String] example: 'Person Name'
    # @param domain [String] example: 'google.com'
    #
    # @return [String] a generated email address or a no-data-available notice
    def predicted_email_for(name:, domain:)
      if analyzed_data[domain].nil?
        return 'No training data available for that email domain.'
      end

      email_to_predict = PartialEmail.new(name, domain)
      email_formatter  = analyzed_data[domain]

      email_formatter.predict_address_for(email: email_to_predict)
    end

    private

    # Parses data from a hash, for each entry mapping a name to an EmailFormat
    # object, the most frequently found email format for that given email domain
    #
    # @param training_set [Hash] format: { 'Person Name' => 'p.name@email.com'}
    #
    # @return [Hash] format: { 'Person Name' => <EmailFormat::FirstInitialDotLastName> }
    def classify_data(training_set)
      formats = email_formats_from(training_set)
      grouped_data = formats.group_by(&:domain)

      grouped_data.each_pair do |domain, found_formats|
        grouped_data[domain] = most_frequent_class(found_formats)
      end
    end

    def email_formats_from(email_hsh)
      Email.collection_from(email_hsh).map do |email|
        EmailFormat.detect_for(email: email)
      end
    end

    def most_frequent_class(formats_arr)
      format_names = formats_arr.map(&:class)
      formats_arr.max_by { |format| format_names.count(format.class) }
    end
  end
end
