require 'factor-connector-api'
require 'rest_client'

Factor::Connector.service 'slack' do
  %w(message notification exit enter topic_change).each do |listener_name|
    listener listener_name do
      start do |params|
        channel     = params['channel']
        token       = params['token']
        filter      = params['filter']
        listener_id = "channel_#{listener_name}"

        fail 'Token is required' unless token
        fail 'Channel is required' unless channel
        fail 'Filter is required' if !filter && listener_name == 'message'

        hook_url = get_web_hook(listener_id)

        base = 'https://slack.com/api/channels.history'
        auth = "?token=#{token}&"
        chan = "channel=#{channel}"
        uri  = base + auth + chan

        headers = {
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }

        info 'Getting hooks'
        begin
          http_response = RestClient.get uri, body: {}.to_json, headers: headers
        rescue
          fail 'Could not find your hooks, check your creds.'
        end

        if http_response.body
          response = JSON.parse(http_response.body)
          if response['item']
            hook = response['item'].find { |h| h['url'] == hook_url }
          elsif response['error']
            fail "Couldn't create web hook: #{response['error']['message']}"
          end
        end

        if hook
          info 'Looks like this web hook is already registered'
          hook_id = hook['id']
        else
          info "Creating hook in `#{channel}` room"
          begin
            body = {
              url: hook_url,
              event: listener_id,
              name: 'workflow'
            }
            body[:pattern] = filter if filter
            post_params = {
              body: body.to_json,
              headers: headers
            }
            http_response = RestClient.post uri, post_params
          rescue
            fail 'Could not connect to Slack'
          end

          if http_response.body
            response = JSON.parse(http_response.body)
            if response['error']
              fail "Could not create web hook: #{response['error']['message']}"
            elsif response['id']
              hook_id = response['id']
            end
          end
        end

        hook_url = web_hook id: listener_id do
          start do |listener_start_params, hook_data, _req, _res|
            info 'Triggering workflow...'
            begin
              filter = listener_start_params['filter']

              if hook_data['item']['message'] && hook_data['item']['message']['message']
                original_message = hook_data['item']['message']['message']
                hook_data['message']  = original_message

              if filter
                regexp               = Regexp.new(filter)
                matches              = regexp.match(original_message).captures
                hook_data['matches'] = matches
              end
            end

            hook_data['hook_id']  = hook_id
            rescue => ex
              fail "Could not parse message from Slack", exception: ex
            end

            begin
              start_workflow hook_data
            rescue => ex
              fail 'Internal error: failed to send message for next step', exception: ex
            end
          end
        end

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

          info "Posting message `#{text}` to channel #{channel}"
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
    end
  end
end

