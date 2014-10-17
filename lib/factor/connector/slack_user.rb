require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack_user' do
  action 'list' do |params|

    token = params['token']

    fail 'Token is required' unless token

    payload = {
      token: token
    }

    info 'Listing Users'
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

    action_callback response
  end
end
