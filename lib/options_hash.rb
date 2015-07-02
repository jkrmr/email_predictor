require 'optparse'

class OptionsHash
  attr_reader :options, :parser

  def initialize
    @options = {}
    parse_options
  end

  def valid?
    !invalid_switches_present?
  end

  def banner
    parser.banner
  end

  private

  def parse_options
    @parser ||= setup_option_parser
    @parser.parse!

  rescue OptionParser::InvalidOption
    options[:unrecognized_switch] = true
    puts banner
  end

  def invalid_switches_present?
    options[:unrecognized_switch] == true
  end

  def setup_option_parser
    OptionParser.new do |opts|
      opts.banner = USAGE_NOTES
      opts.separator 'Options:'

      opts.on('-t', '--training_set',
        'path to JSON training data (default: data/training.json)'
      ) do |opt|
        options[:training_set] = opt
      end

      opts.on('-v', '--version', 'display version') do
        puts 'Email Predictor v' + EmailPredictor::VERSION.join('.')
        exit 0
      end

      opts.on('-h', '--help', 'display this screen') do
        puts opts
        exit 0
      end
    end
  end


  USAGE_NOTES = <<-TXT.gsub(/^ +/, '')
    Usage:
        predict  NAME  DOMAIN [--training_set JSON_FILEPATH]

    Example:
        predict 'Jane Doe' google.com [-t data/training.json]

  TXT
end
