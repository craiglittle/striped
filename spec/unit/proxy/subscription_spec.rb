require 'helper'
require 'striped/proxy/subscription'

describe Striped::Proxy::Subscription do
  let(:client)       { double('client') }
  let(:customer_id)  { 'customer_id' }
  let(:api_response) { double('API response') }
  let(:arguments)    { double('arguments') }
  subject(:subscription_proxy) do
    Striped::Proxy::Subscription.new(client, customer_id)
  end

  before do
    [:post].each do |method|
      client.stub(method).and_return(api_response)
    end
  end

  describe "#update" do
    before { @response = subscription_proxy.update(arguments) }

    it "sends a request to update a customer's subscription" do
      expect(client).to have_received(:post).with("/customers/#{customer_id}/subscription", body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
