require 'helper'
require 'striped/proxy/token'

describe Striped::Proxy::Token do
  let(:client)      { double('client') }
  let(:resource)    { 'tokens' }
  let(:resource_id) { 'token_id' }
  subject(:proxy)   { Striped::Proxy::Token.new(client, resource_id) }

  it_executes_a_valid_operation :create
end

