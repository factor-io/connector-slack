require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
    @channel = ENV['SLACK_CHANNEL']
    @text = ENV['SLACK_TEXT']
    @user = ENV['SLACK_USER']
  end

  it 'can send a message' do
    service_instance = service_instance('slack_chat')
    params = {
      'token' => @token,
      'channel' => '#general',
      'text' => @text
    }
    service_instance.test_action('send', params) do
      expect_info message: "Posting Message"
    end
  end
end
