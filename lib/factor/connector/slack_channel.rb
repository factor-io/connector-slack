require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_channel' do
  action "list" do |params|

    token = params['token']

    fail 'Token is required' unless token

    payload = {
      token: token
    }

    info "Getting all Channels"
    begin
      uri          = 'https://slack.com/api/channels.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action "invite" do |params|
    token   = params['token']
    channel = params['channel']
    user    = params['user']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'Username is required' unless user

    payload = {
      token: token
    }

    info "Getting all Channels"
    begin
      uri          = 'https://slack.com/api/channels.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    response['channels'].each do |n|
      if n['name'] == channel
        channel = n['id']
      end
    end

    info "Getting Users"
    begin
      uri          = 'https://slack.com/api/users.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    response['members'].each do |n|
      if n['name'] == user
        user = n['id']
      end
    end

    payload = {
      token:   token,
      channel: channel,
      user:    user
    }

    info "Inviting #{user} to #{channel}"
    begin
      uri          = 'https://slack.com/api/channels.invite'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action "history" do |params|

    token   = params['token']
    channel = params['channel']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel

    payload = {
      token: token
    }

    info "Getting all Channels"
    begin
      uri          = 'https://slack.com/api/channels.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    response['channels'].each do |n|
      if n['name'] == channel
        channel = n['id']
      end
    end

    payload = {
      token: token,
      channel: channel,
    }

    info "Getting History for #{channel}"
    begin
      uri = 'https://slack.com/api/channels.history'
      raw_reponse = RestClient.post(uri, payload)
      response = JSON.parse(raw_reponse)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action "topic" do |params|

    token   = params['token']
    channel = params['channel']
    topic   = params['topic']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'Topic is required' unless topic

    payload = {
      token: token
    }

    info "Getting all Channels"
    begin
      uri          = 'https://slack.com/api/channels.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    response['channels'].each do |n|
      if n['name'] == channel
        channel = n['id']
      end
    end

    payload = {
      token: token,
      channel: channel,
      topic: topic
    }

    info "Setting Topic"
    begin
      uri = 'https://slack.com/api/channels.setTopic'
      raw_reponse = RestClient.post(uri, payload)
      response = JSON.parse(raw_reponse)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end
end
