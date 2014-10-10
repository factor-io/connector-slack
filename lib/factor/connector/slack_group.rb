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
end
