require 'spec_helper'

describe 'slack' do
  it 'can send a message' do

    token = ENV['token']

    service_instance = service_instance('slack')

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

    token = ENV['token']
    file = ENV['file']
    channel = ENV['channel']
    content = File.open(file, 'rb').read

    service_instance = service_instance('slack')

    params = {
      'token' => token,
      'channel' => channel,
      'file' => file,
      'content' => content
    }

    service_instance.test_action('upload', params) do
      expect_info
    end
  end
end
