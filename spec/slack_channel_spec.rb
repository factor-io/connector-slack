require 'spec_helper'

describe SlackConnectorDefinition do
  describe 'channel' do
    it 'can invite a user' do
      # @runtime.run([:channel,:invite], token:@token, channel:@channel, user:'skierkowski')
      # expect(@runtime).to respond
      # kick_user(@channel, @user)
    end

    it 'can list all channels' do
      @runtime.run([:channel,:list], token:@token)
      expect(@runtime).to respond
    end

    it 'can see history of channel' do
      @runtime.run([:channel,:history], token:@token, channel:@channel)
      expect(@runtime).to respond
    end

    it 'can set channel topic' do
      # @runtime.run([:channel,:topic], token:@token, channel:@channel, topic:'foo')
      # expect(@runtime).to respond
    end
  end
end

