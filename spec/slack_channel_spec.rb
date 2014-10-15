require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
    @channel = ENV['SLACK_CHANNEL']
    @text = 'text'
    @user = ENV['SLACK_USER']
  end

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
      expect_return
    end
  end

    it 'can see history of channel' do
    service_instance = service_instance('slack_channel')
    params = {
      'token'   => @token,
      'channel' => @channel,
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
      expect_return
    end
  end
end
