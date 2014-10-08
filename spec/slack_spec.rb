require 'spec_helper'

describe 'Slack' do
  it 'can send a message' do

    token = ENV['token']
    channel  = ENV['channel']

    service_instance = service_instance('slack')

    params = {
      'token' => token,
      'channel' => channel,
      'text' => 'hey'
    }

    service_instance.test_action('send',params) do
      expect_info
    end
  end
end
