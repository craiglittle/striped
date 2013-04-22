require 'helper'
require 'striped/proxy/discount'

describe Striped::Proxy::Discount do
  let(:client)       { double('client') }
  let(:arguments)    { double('arguments') }
  let(:api_response) { double('api_response') }
  let(:resource_id)  { 'customer_id' }
  subject(:proxy)    { Striped::Proxy::Discount.new(client, resource_id) }

  before do
    client.stub(:delete).and_return(api_response)
  end

  describe "#delete" do
    before { @response = proxy.delete }

    it "sends a request to delete a customer's discount" do
      expect(client).to(
        have_received(:delete).with("/customers/#{resource_id}/discount")
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
