require 'spec_helper'

describe SlackConnectorDefinition do
  describe 'user' do
    it 'can list all users' do
      @runtime.run([:user,:list], token:@token)
      expect(@runtime).to respond
    end
  end
end
