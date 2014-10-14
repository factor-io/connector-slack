require 'spec_helper'

describe 'slack' do

  before(:each) do
    @token = ENV['SLACK_TOKEN']
    @file = Tempfile.new('foo')
    @content = @file.read
  end

  after(:each) do
    @file.unlink
    @content = nil
  end

  it 'can upload a file' do
    file = Tempfile.new('foo')
    content = file.read
    service_instance = service_instance('slack_file')
    params = {
      'token' => @token,
      'channel' => '#general',
      'file' => @file,
      'content' => @content
    }
    service_instance.test_action('upload', params) do
      expect_info message: "Uploading File"
    end
  end
end
