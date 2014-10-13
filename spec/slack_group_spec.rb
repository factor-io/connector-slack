require 'spec_helper'

describe 'slack' do
  it 'can create a private group' do

    token = ENV['SLACK_TOKEN']

    service_instance = service_instance('slack_group')

    params = {
      'token' => token,
      'name' => 'privategroupname'
    }

    service_instance.test_action('create', params) do
      expect_info message: "Creating Group"
    end
  end

  it 'Invite a user to a private group' do

    token   = ENV['SLACK_TOKEN']
    channel = ENV['SLACK_CHANNEL']
    name    = 'factorbot'

    service_instance = service_instance('slack_group')

    params = {
      'token' => token,
      'channel' => channel,
      'user' => name
    }

    service_instance.test_action('invite', params) do
      expect_info message: "Inviting User"
    end
  end
end
