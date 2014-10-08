require 'spec_helper'

describe 'slack' do
  it 'can send a message' do

    token = ENV['SLACK_TOKEN']

    service_instance = service_instance('slack')

    params = {
      'token'   => token,
      'channel' => '#general',
      'text'    => 'whatup'
    }

    service_instance.test_action('send', params) do
      expect_info message: 'Message Sent'
      expect_return
    end
  end
end
