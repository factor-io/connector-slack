require 'spec_helper'

describe 'slack' do

  before(:each) do
    @token = ENV['SLACK_TOKEN']
    @user = ENV['SLACK_USER']
    @seed = Random.new(1234)
    @group = 'text-' + Random.rand(9999).to_s
    @name = 'text-' + Random.rand(9999).to_s
    uri = 'https://slack.com/api/groups.create'
    payload = {
      token: @token,
      name: @group
    }
    RestClient::Request.execute(
                          url: uri,
                          method: 'POST',
                          ssl_version: 'SSLv23',
                          payload: payload
                          )
  end

  after(:each) do
    uri = 'https://slack.com/api/groups.kick'
    payload = {
      token: @token,
      channel: @group,
      user: @user
    }
    RestClient::Request.execute(
                          url: uri,
                          method: 'POST',
                          ssl_version: 'SSLv23',
                          payload: payload
                          )
  end

  describe 'group' do
    it 'can create a private group' do
      service_instance = service_instance('slack_group')
      params = {
        'token' => @token,
        'name' => @name
      }
      service_instance.test_action('create', params) do
        return_info = expect_return
        expect(return_info[:payload]).to include('group')
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
        return_info = expect_return
        expect(return_info[:payload]).to include('group')
      end
    end
  end
end
