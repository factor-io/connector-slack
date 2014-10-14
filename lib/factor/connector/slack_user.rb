require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_user' do
  action 'list' do |params|

    token = params['token']

    fail "Token is required" unless token

    payload = {
      token: token
    }

  info "Listing Users"
    begin
      uri          = 'https://slack.com/api/users.list'
      raw_response = RestClient.post(uri, payload)
      response     = JSON.parse(raw_response)
    rescue
      fail "Error from Slack API: #{response['error']}" unless response['ok']
    end

    action_callback response
  end
end
