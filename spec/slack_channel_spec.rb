require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
    @text = 'text'
    @user = ENV['SLACK_USER']
    @channel = ENV['SLACK_CHANNEL']
  end

  after(:each) do
    uri = 'https://slack.com/api/channels.kick'
    payload = {
      token: @token,
      channel: @channel,
      user: @user
    }
    RestClient::Request.execute(
                          url: uri,
                          method: 'POST',
                          ssl_version: 'SSLv23',
                          payload: payload
                          )
  end

  describe 'channel' do
    it 'can invite a user' do
      service_instance = service_instance('slack_channel')
      params = {
        'token' => @token,
        'channel' => @channel,
        'user' => @user
      }
      service_instance.test_action('invite', params) do
        expect_return
      end
    end

    it 'can list all channels' do
      service_instance = service_instance('slack_channel')
      params = {
        'token' => @token
      }
      service_instance.test_action('list', params) do
        return_info = expect_return
        expect(return_info).to be_a(Hash)
        expect(return_info).to include(:payload)
        expect(return_info[:payload]).to be_a(Hash)
        expect(return_info[:payload]).to include('channels')
      end
    end

    it 'can see history of channel' do
      service_instance = service_instance('slack_channel')
      params = {
        'token'   => @token,
        'channel' => @channel
      }
      service_instance.test_action('history', params) do
        expect_return
      end
    end

    it 'can set channel topic' do
      service_instance = service_instance('slack_channel')
      params = {
        'token'   => @token,
        'channel' => @channel,
        'topic'   => @text
      }
      service_instance.test_action('topic', params) do
        expect_return[:topic] = @text
      end
    end
  end
end
