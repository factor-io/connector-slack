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
      expect_info message: "Posting Message"
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
      expect_info message: "Uploading File"
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
      expect_info message: "Inviting User"
    end
  end

  it 'can set channel topic' do

    token   = ENV['SLACK_TOKEN']

    service_instance = service_instance('slack_channel')

    params = {
      'token'   => token,
      'channel' => '#general',
      'topic'   => 'We have saved the whales'
    }

    service_instance.test_action('topic', params) do
      expect_info message: "Setting Topic"
    end
  end
end
