require 'factor-connector-api'
require 'rest-client'

Factor::Connector.service 'slack_chat' do
  action 'send' do |params|

    token        = params['token']
    channel_name = params['channel']
    text         = params['text']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel_name
    fail 'Text is required' unless text

    payload = {
      token: token
    }

    info 'Getting all Channels'
    begin
      uri          = 'https://slack.com/api/channels.list'
      raw_response = RestClient::Request.execute(
                                          url: uri,
                                          method: 'POST',
                                          ssl_version: 'SSLv23',
                                          payload: payload
                                        )
      response     = JSON.parse(raw_response)
    rescue
      fail 'failed to connect to Slack API, check your credentials'
    end

    fail response['error'] unless response['ok']

    channel = response['channels'].find { |c| c['name'] || c['id'] == channel_name }

    fail "Channel '#{channel_name}' wasn't found" unless channel

    channel_id = channel['id']

    payload = {
      token:   token,
      channel: channel_id,
      text:    text
    }

    info 'Posting Message'
    begin
      uri          = 'https://slack.com/api/chat.postMessage'
      raw_response = RestClient::Request.execute(
                                          url: uri,
                                          method: 'POST',
                                          ssl_version: 'SSLv23',
                                          payload: payload
                                        )
      response     = JSON.parse(raw_response)
    rescue
      fail 'failed to connect to Slack API, check your credentials'
    end

    fail response['error'] unless response['ok']

    action_callback response
  end
end
