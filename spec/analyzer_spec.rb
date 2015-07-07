require 'spec_helper'

module EmailPredictor
  describe Analyzer do
    subject(:analyzer) { Analyzer.new(training_set: test_data) }

    describe '#classify_data' do
      it 'groups email data by email domain' do
        email_domains = analyzer.analyzed_data.keys

        expect(email_domains).to eq %w(alphasights.com google.com)
      end

      it 'maps each email domain to an email format' do
        formats = analyzer.analyzed_data.values

        expect(formats).to be_an_array_of Emails::EmailFormat
      end

      it 'maps each domain to its most frequently occurring format' do
        most_common_format = analyzer.analyzed_data['google.com']

        expect(most_common_format).to be_a Emails::EmailFormat::FirstNameDotLastName
      end
    end

    describe '#predicted_email_for' do
      context 'when no training data is provided for the given email domain' do
        it 'returns a string saying no data were available for a prediction' do
          result = analyzer.predicted_email_for(name: 'j e', domain: 'em.com')
          message = 'No training data available for that email domain.'

          expect(result).to eq message
        end
      end

      context 'when training data for the given domain is provided' do
        it 'returns a string version of the predicted email' do
          result = analyzer.predicted_email_for(
            name: 'jane eyre',
            domain: 'google.com'
          )

          expect(result).to eq 'jane.eyre@google.com'
        end
      end
    end

    def test_data
      {
        'John Ferguson' => 'john.ferguson@alphasights.com',
        'Jane Doe' => 'jane.doe@alphasights.com',
        'Damon Aw' => 'damon.aw@google.com',
        'Charles Beckworth' => 'charles.beckworth@google.com',
        'Lewis Puller' => 'l.p@google.com',
        'Ferguson John ' => 'ferguson.john@alphasights.com',
        'Doe Jane' => 'doe.jane@alphasights.com',
        'Aw Damon' => 'aw.damon@google.com',
        'Beckworth Charles' => 'beckworth.charles@google.com',
        'Puller Lewis' => 'p.l@google.com'
      }
    end
  end
end
