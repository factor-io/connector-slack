require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_group' do
  action 'create' do |params|

    token = params['token']
    name  = params['name']

    fail 'Token is required' unless token
    fail 'Name required' unless name

    payload = {
      token: token,
      name:  name
    }

    info 'Creating Group'
    begin
      uri          = 'https://slack.com/api/groups.create'
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
      uri          = 'https://slack.com/api/groups.list'
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

    channel = response['groups'].find { |c| c['name'] == channel_name }

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

    user = response['members'].find { |m|  m['name'] == user_name }

    fail "User '#{user_name}' was not found" unless user

    user_id = user['id']

    payload = {
      token:   token,
      channel: channel_id,
      user:    user_id
    }

    info 'Inviting User'
    begin
      uri          = 'https://slack.com/api/groups.invite'
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
