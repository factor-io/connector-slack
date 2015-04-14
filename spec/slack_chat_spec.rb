require 'spec_helper'

describe SlackConnectorDefinition do

  before(:all) do
    @token   = ENV['SLACK_TOKEN']
    @user    = ENV['SLACK_USER']
    @channel = 'test'
  end
  describe 'chat' do
    it 'can send a message' do
      @runtime = Factor::Connector::Runtime.new(SlackConnectorDefinition)

      @runtime.run([:chat,:send], token:@token, channel:@channel, text:'hello world')

      expect(@runtime).to respond ok:true
    end
  end
end
