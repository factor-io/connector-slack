require 'factor/connector/definition'
require 'rest-client'

class SlackConnectorDefinition < Factor::Connector::Definition
  id :slack

  def get_resource(resource,token,payload={})
    uri             = "https://slack.com/api/#{resource}"
    payload[:token] = token
    raw_response    = RestClient::Request.execute(url:uri, method:'POST', ssl_version:'SSLv23', payload:payload)
    response        = JSON.parse(raw_response, symbolize_names: true)
    fail response['error'] unless response['ok']
    response
  rescue
    fail "Failed to connect to Slack API, check your credentials"
  end

  def load_and_validate(params,key,requirements={})
    value = params[key]
    name = key.to_s.split('_').map{|e| e.capitalize}.join(' ')

    if requirements[:required]
      fail "#{name} (:#{key.to_s}) is required" unless value
    elsif requirements[:is_a]
      fail "#{name} (:#{key.to_s}) must be a #{requirements[:is_a]}" unless value.is_a?(requirements[:is_a])
    end

    value
  end

  def look_up_channel(token,channel_name_or_id)
    info "Getting information for channel '#{channel_name_or_id}'"
    channel_list = get_resource('channels.list', token) || {}
    channels = channel_list['channels'] || []
    channel = channels.find {|c| c['name']==channel_name_or_id || c['id']==channel_name_or_id}
    fail "No Channel found with name or id '#{channel_name_or_id}'" unless channel
    channel
  end

  def look_up_user(token, user_name_or_id)
    info "Getting information for user '#{user_name_or_id}'"
    user_list = get_resource('users.list', token) || {}
    users = user_list['members'] || []
    user = users.find {|c| c['name']==user_name_or_id || c['id']==user_name_or_id}
    fail "No User found with name or id '#{user_name_or_id}'" unless user
    user
  end

  resource :channel do
    action :list do |params|
      token = load_and_validate(params,:token, required:true)

      info "Getting all Channels"
      response = get_resource('channels.list', token, token:token)
      
      respond response
    end

    action :invite do |params|
      token              = load_and_validate(params,:token, required:true)
      channel_name_or_id = load_and_validate(params,:channel, required:true)
      user_name_or_id    = load_and_validate(params,:user, required:true)

      channel = look_up_channel(token,channel_name_or_id)
      user    = look_up_user(token,user_name_or_id)

      info "Inviting user '#{user['id']}'' to channel '#{channel}'"
      invite_response = get_resource('channels.invite', token, user:user['id'], channel:channel['id']) || {}

      respond invite_response
    end

    action :history do |params|
      token              = load_and_validate(params,:token, required:true)
      channel_name_or_id = load_and_validate(params,:channel, required:true)

      channel = look_up_channel(token,channel_name_or_id)

      info "Getting history list for channel '#{channel['id']}'"
      history = get_resource('channels.history', token, channel:channel['id']) || {}

      respond history
    end

    action :topic do |params|
      token              = load_and_validate(params,:token, required:true)
      channel_name_or_id = load_and_validate(params,:channel, required:true)
      topic              = load_and_validate(params,:topic, required:true)

      channel = look_up_channel(token,channel_name_or_id)

      info "Setting topic for channel '#{channel['id']}'"
      topic = get_resource('channels.setTopic', token, channel:channel['id'], topic:topic) || {}

      respond topic
    end
  end

  resource :chat do
    action :send do |params|
      token              = load_and_validate(params,:token, required:true)
      channel_name_or_id = load_and_validate(params,:channel, required:true)
      text               = load_and_validate(params,:text, required:true, is_a:String)

      channel = look_up_channel(token,channel_name_or_id)

      info "Posting a message to channel '#{channel['id']}'"
      topic = get_resource('chat.postMessage', token, channel:channel['id'], text:text) || {}

      respond topic
    end
  end

  resource :group do
    action :create do |params|
      token = load_and_validate(params,:token, required:true)
      name  = load_and_validate(params,:name, required:true)

      info "Creating a new group with name '#{name}'"
      group = get_resource('groups.create', token, name:name)

      respond group
    end
  end

  resource :user do
    action :list do |params|
      token = load_and_validate(params,:token, required:true)

      info "Getting all Users"
      users = get_resource('users.list', token, token:token)
      
      respond users
    end
  end
end