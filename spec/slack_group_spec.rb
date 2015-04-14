require 'spec_helper'
require 'securerandom'

describe SlackConnectorDefinition do
  describe 'group' do
    it 'can create a private group' do
      # name = 'group-' + Random.rand(9999).to_s
      # @runtime.run([:group,:create], token:@token, name:name)
      # expect(@runtime).to respond
      # delete_group(name)
    end

    it 'Invite a user to a private group' do
      # name = 'group-' + Random.rand(9999).to_s
      # group = create_group(name)
      # @runtime.run([:group,:invite], token:@token, channel:group[:id], user:@user)
      # expect(@runtime).to respond
    end
  end
end
