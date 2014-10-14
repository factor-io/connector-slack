require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_chat' do
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

    info "Posting Message"
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
end
