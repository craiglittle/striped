require 'helper'
require 'striped/proxy/invoice'

describe Striped::Proxy::Invoice do
  let(:client)      { double('client') }
  let(:resource)    { 'invoices' }
  let(:resource_id) { 'invoice_id' }
  subject(:proxy)   { Striped::Proxy::Invoice.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :update, :all

  describe "#pay" do
    before { @response = proxy.pay }

    it "sends a request to pay an invoice" do
      expect(client).to(
        have_received(:post).with("/invoices/#{resource_id}/pay")
      )
    end

    it_returns_the_api_response
  end
end
