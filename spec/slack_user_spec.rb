require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
  end

  it 'can list all channels' do
    service_instance = service_instance('slack_channel')
    params = {
      'token' => @token
    }
    service_instance.test_action('list', params) do
      expect_info message: "Getting Channels"
    end
  end
end
