require 'rspec/expectations'

RSpec::Matchers.define :be_an_array_of do |expected|
  match do |actual|
    actual.instance_of?(Array) && actual.all? { |el| el.is_a?(expected) }
  end

  failure_message do |actual|
    "expected that #{actual} would be an array composed of #{expected}"
  end
end
