require 'spec_helper'
require 'pry'

describe 'slack' do

  before(:each) do
    @token = ENV['SLACK_TOKEN']
    @channel = ENV['SLACK_CHANNEL']
    @new_file = Tempfile.new(ENV['SLACK_TEXT'])
    @file = @new_file.path
    @content = ENV['SLACK_TEXT']
  end

  after(:each) do
    @new_file.unlink
  end

  it 'can upload a file' do
    service_instance = service_instance('slack_file')
    params = {
      'token' => @token,
      'channel' => @channel,
      'file' => @file,
      'content' => @content
    }
    service_instance.test_action('upload', params) do
      expect_return
    end
  end
end
