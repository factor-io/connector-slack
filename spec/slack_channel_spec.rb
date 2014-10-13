require 'spec_helper'

describe 'slack' do
  it 'can send a message' do

    token = ENV['SLACK_TOKEN']

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

    token = ENV['SLACK_TOKEN']
    file = Tempfile.new('foo')
    content = file.read

    service_instance = service_instance('slack_channel')

    params = {
      'token' => token,
      'channel' => '#general',
      'file' => file,
      'content' => content
    }

    service_instance.test_action('upload', params) do
      expect_info
      file.unlink
    end
  end

  it 'can invite a user' do

    token = ENV['SLACK_TOKEN']

    service_instance = service_instance('slack_channel')

    params = {
      'token' => token,
      'channel' => '#general',
      'user' => 'user'
    }

    service_instance.test_action('invite', params) do
      expect_info
    end
  end
end
