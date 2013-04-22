require 'helper'
require 'striped/proxy/invoice'

describe Striped::Proxy::Invoice do
  let(:client)      { double('client') }
  let(:resource)    { 'invoices' }
  let(:resource_id) { 'invoice_id' }
  subject(:proxy)   { Striped::Proxy::Invoice.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :update
end
