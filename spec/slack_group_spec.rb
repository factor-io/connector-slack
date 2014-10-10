require 'spec_helper'

token = ENV['token']

describe 'slack' do
  it 'can create a private group' do

    service_instance = service_instance('slack_group')

    params = {
      'token' => token,
      'name' => 'privategroupname'
    }

    service_instance.test_action('create', params) do
      expect_info
    end
  end
end
