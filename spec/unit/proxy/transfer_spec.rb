require 'helper'
require 'striped/proxy/transfer'

describe Striped::Proxy::Transfer do
  let(:client)      { double('client') }
  let(:resource)    { 'transfers' }
  let(:resource_id) { 'transfer_id' }
  subject(:proxy)   { Striped::Proxy::Transfer.new(client, resource_id) }

  it_executes_a_valid_operation :fetch, :all
end
