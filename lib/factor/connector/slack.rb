require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack' do
  action "send" do |params|

    token   = params['token']
    channel = params['channel']
    text    = params['text']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'Text is required' unless text

    payload = {
      token:   token,
      channel: channel,
      text:    text
    }

    info "Posting message `#{text}` to channel #{channel}"
    begin
      uri          = 'https://slack.com/api/chat.postMessage'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail 'Unable to deliver your message'
    end

    fail "Error from Slack API: #{response['error']}" unless response['ok']

    action_callback response
  end

  action "upload" do |params|
    token   = params['token']
    channel = params['channel']
    file    = params['file']
    content = params['content'] || File.open(file, 'rb').read

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'File is required' unless file

    body = {
      token:   token,
      channel: channel,
      file:    file,
      content: content
    }

    info "Uploading File `#{file}` to channel #{channel}"
    begin
      uri          = 'https://slack.com/api/files.upload'
      raw_response = RestClient.post(uri, body)
      reponse      = JSON.parse(raw_response)
    rescue
      fail 'Unable to upload you file'
    end

    fail "Error from Slack API: #{response['error']}" unless response['ok']

    action_callback response
  end
end
