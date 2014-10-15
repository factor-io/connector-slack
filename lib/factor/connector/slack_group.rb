require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_group' do
  action "create" do |params|

    token = params['token']
    name  = params['name']

    fail 'Token is required' unless token
    fail 'Name required' unless name

    payload = {
      token: token,
      name:  name,
    }

    info "Creating Group"
    begin
      uri          = 'https://slack.com/api/groups.create'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end

  action "invite" do |params|

    token      = params['token']
    channel    = params['channel']
    user       = params['user']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'Username is required' unless user

    payload = {
      token:   token,
      channel: channel,
      user:    user
    }

    info "Inviting User"
    begin
      uri          = 'https://slack.com/api/groups.invite'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Failed to connect to Slack API, check your credentials"
    end

    fail response['error'] unless response['ok']

    action_callback response
  end
end
