require 'spec_helper'

describe 'slack' do

  before(:each) do
    @token = ENV['SLACK_TOKEN']
    @user = ENV['SLACK_USER']
    @group = ENV['SLACK_GROUP']
    uri = 'https://slack.com/api/groups.create'
    @name = Random.new_seed.to_s
    payload = {
      token: @token,
      name: @name
    }
    raw_response = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
  end

  after(:each) do
    uri = 'https://slack.com/api/groups.kick'
    payload = {
      token: @token,
      channel: @group,
      user: @user
    }
    raw_response = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
  end

  it 'can create a private group' do
    service_instance = service_instance('slack_group')
    params = {
      'token' => @token,
      'name' => @name
    }
    service_instance.test_action('create', params) do
      expect_return
    end
  end

  it 'Invite a user to a private group' do
    service_instance = service_instance('slack_group')
    params = {
      'token' => @token,
      'channel' => @group,
      'user' => @user
    }
    service_instance.test_action('invite', params) do
      expect_return
    end
  end
end
