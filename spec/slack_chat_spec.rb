require 'spec_helper'

describe SlackConnectorDefinition do

  describe 'chat' do
    it 'can send a message' do
      @runtime.run([:chat,:send], token:@token, channel:@channel, text:'hello world')
      expect(@runtime).to respond
    end
  end
end
