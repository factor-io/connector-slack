require 'spec_helper'

describe 'slack' do

  before(:all) do
    @token = ENV['SLACK_TOKEN']
  end

  describe 'user' do
    it 'can list all users' do
      service_instance = service_instance('slack_user')
      params = {
        'token' => @token
      }
      service_instance.test_action('list', params) do
        return_info = expect_return
        expect(return_info[:payload]).to include('members')
      end
    end
  end
end
