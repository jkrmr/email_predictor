LIB = File.expand_path('../../lib', __FILE__)

require 'email_predictor/version'

Dir["#{LIB}/emails/**/*.rb"].each do |file|
  require file
end

require 'analyzer'
