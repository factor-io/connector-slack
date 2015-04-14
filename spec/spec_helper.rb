require "codeclimate-test-reporter"
require 'rspec'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

Dir.glob('./lib/factor-connector-slack.rb').each { |f| require f }

RSpec.configure do |c|
end
