require 'spec_helper'

token = ENV['token']
file = ENV['file']
channel = ENV['channel']
content = File.open(file, 'rb').read

describe 'slack' do
  it 'can send a message' do

    service_instance = service_instance('slack_channel')

    params = {
      'token' => token,
      'channel' => '#general',
      'text' => 'whatup'
    }

    service_instance.test_action('send', params) do
      expect_info
    end
  end

  it 'can upload a file' do

    service_instance = service_instance('slack_channel')

    params = {
      'token' => token,
      'channel' => '#general',
      'file' => 'file.txt',
      'content' => 'thingandstuff'
    }

    service_instance.test_action('upload', params) do
      expect_info
    end
  end
end
