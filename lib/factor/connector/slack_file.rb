require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_file' do
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

    info "Uploading File"
    begin
      uri          = 'https://slack.com/api/files.upload'
      raw_response = RestClient.post(uri, body)
      response      = JSON.parse(raw_response)
    rescue
      fail "Error from Slack API: #{response['error']}" unless response['ok']
    end

    action_callback response
  end
end
