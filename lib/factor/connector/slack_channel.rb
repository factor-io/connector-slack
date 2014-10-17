require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_channel' do
  action 'list' do |params|

    token = params['token']

    fail 'Token is required' unless token

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
      raise 'failed to connect to Slack API, check your credentials'
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action 'invite' do |params|
    token        = params['token']
    channel_name = params['channel']
    user_name    = params['user']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel_name
    fail 'Username is required' unless user_name

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

    info 'Getting Users'
    begin
      uri          = 'https://slack.com/api/users.list'
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

    user = response['members'].find { |m| m['name'] || m['id'] == user_name }

    fail "User '#{user_name}' was not found" unless user

    user_id = user['id']

    payload = {
      token:   token,
      channel: channel_id,
      user:    user_id
    }

    info "Inviting #{user} to #{channel}"
    begin
      uri          = 'https://slack.com/api/channels.invite'
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

    warn response['error'] unless response['ok']

    action_callback response
  end

  action 'history' do |params|

    token        = params['token']
    channel_name = params['channel']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel_name

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
      token: token,
      channel: channel_id
    }

    info "Getting History for #{channel}"
    begin
      uri = 'https://slack.com/api/channels.history'
      raw_response = RestClient::Request.execute(
                                          url: uri,
                                          method: 'POST',
                                          ssl_version: 'SSLv23',
                                          payload: payload
                                          )
      response = JSON.parse(raw_response)
    rescue
      fail 'failed to connect to Slack API, check your credentials'
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action 'topic' do |params|

    token        = params['token']
    channel_name = params['channel']
    topic        = params['topic']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel_name
    fail 'Topic is required' unless topic

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
      token: token,
      channel: channel_id,
      topic: topic
    }

    info 'Setting Topic'
    begin
      uri = 'https://slack.com/api/channels.setTopic'
      raw_response = RestClient::Request.execute(
                                          url: uri,
                                          method: 'POST',
                                          ssl_version: 'SSLv23',
                                          payload: payload
                                          )
      response = JSON.parse(raw_response)
    rescue
      fail 'failed to connect to Slack API, check your credentials'
    end

    fail response['error'] unless response['ok']

    action_callback response
  end
end
