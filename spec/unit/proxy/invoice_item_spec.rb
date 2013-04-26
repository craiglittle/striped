require 'helper'
require 'striped/proxy/invoice_item'

describe Striped::Proxy::InvoiceItem do
  let(:client)      { double('client') }
  let(:resource)    { 'invoiceitems' }
  let(:resource_id) { 'invoice_item_id' }
  subject(:proxy)   { Striped::Proxy::InvoiceItem.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :update
end
