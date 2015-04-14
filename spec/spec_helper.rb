require "codeclimate-test-reporter"
require 'rspec'
require 'factor/connector/test'
require 'factor/connector/runtime'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

require 'factor-connector-slack'

RSpec.configure do |c|
  c.include Factor::Connector::Test
  c.before(:all) do
    @token   = ENV['SLACK_TOKEN']
    @user    = ENV['SLACK_USER']
    @channel = 'test'
    @runtime = Factor::Connector::Runtime.new(SlackConnectorDefinition)
  end

  def delete_group(group)
    uri = 'https://slack.com/api/groups.delete'
    payload = {
      token:   @token,
      channel: group,
    }
    raw_response = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
    response = JSON.parse(raw_response, symbolize_names: true)
    response
  end

  def kick_user(channel,user)
    uri = 'https://slack.com/api/channels.kick'
    payload = {
      token:   @token,
      channel: channel,
      user:    user
    }
    raw_response = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
    response = JSON.parse(raw_response, symbolize_names: true)
    response
  end

  def create_group(name)
    uri = 'https://slack.com/api/groups.create'
    payload = {
      token: @token,
      name: name
    }
    raw_response = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
    response = JSON.parse(raw_response, symbolize_names: true)
    response
  end
end
