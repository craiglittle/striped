require 'helper'
require 'striped/proxy/plan'

describe Striped::Proxy::Plan do
  let(:client)      { double('client') }
  let(:resource)    { 'plans' }
  let(:resource_id) { 'plan_id' }
  subject(:proxy)   { Striped::Proxy::Plan.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :update, :delete
end
