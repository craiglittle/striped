require 'helper'
require 'striped/proxy/event'

describe Striped::Proxy::Event do
  let(:client)      { double('client') }
  let(:resource)    { 'events' }
  let(:resource_id) { 'event_id' }
  subject(:proxy)   { Striped::Proxy::Event.new(client, resource_id) }

  it_executes_a_valid_operation :fetch
end

