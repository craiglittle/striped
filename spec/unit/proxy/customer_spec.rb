require 'helper'
require 'striped/proxy/customer'

describe Striped::Proxy::Customer do
  let(:client)             { double('client') }
  let(:customer_id)        { 'customer_id' }
  let(:api_response)       { double('API response') }
  let(:arguments)          { double('arguments') }
  subject(:customer_proxy) { Striped::Proxy::Customer.new(client, customer_id) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  describe "#create" do
    before { @response = customer_proxy.create(arguments) }

    it "sends a request to create a customer" do
      expect(client).to have_received(:post).with('/customers', body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
