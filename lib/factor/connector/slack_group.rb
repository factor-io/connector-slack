require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_group' do
  action "create" do |params|

    token = params['token']
    name  = params['name']

    fail 'Token is required' unless token
    fail 'Name is required' unless name

    payload = {
      token: token,
      name:  "thing",
    }

    info "Creating group `#{name}`"
    begin
      uri          = 'https://slack.com/api/groups.create'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail 'Unable to create group'
    end

    fail "Error from Slack API: #{response['error']}" unless response['ok']

    action_callback response
  end

  action "invite" do |params|

    token      = params['token']
    channel_id = params['channel_id']
    user_id    = params['user_id']

    fail 'Token is required' unless token
    fail 'Channel is required' unless channel
    fail 'Username is required' unless user

    payload = {
      token:   token,
      channel: channel_id,
      user:    user_id
    }

    info "Inviting #{user} to group #{channel}"
    begin
      uri          = 'https://slack.com/api/groups.invite'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail 'Unable to invite user'
    end

    fail "Error from Slack API: #{response['error']}" unless response['ok']

    action_callback response
  end
end
