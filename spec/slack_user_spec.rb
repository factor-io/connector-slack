require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
  end

  it 'can list all users' do
    service_instance = service_instance('slack_user')
    params = {
      'token' => @token
    }
    service_instance.test_action('list', params) do
      expect_return
    end
  end
end
