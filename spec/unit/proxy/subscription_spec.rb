require 'helper'
require 'striped/proxy/subscription'

describe Striped::Proxy::Subscription do
  let(:client)       { double('client') }
  let(:arguments)    { double('arguments') }
  let(:api_response) { double('api_response') }
  let(:resource_id)  { 'customer_id' }
  subject(:proxy)    { Striped::Proxy::Subscription.new(client, resource_id) }

  before do
    [:post, :delete].each do |method|
      client.stub(method).and_return(api_response)
    end
  end

  describe "#update" do
    before { @response = proxy.update(arguments) }

    it "sends a request to update a customer's subscription" do
      expect(client).to(
        have_received(:post)
          .with("/customers/#{resource_id}/subscription", body: arguments)
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#cancel" do
    before { @response = proxy.cancel }

    it "sends a request to cancel a customer's subscription" do
      expect(client).to(
        have_received(:delete).with("/customers/#{resource_id}/subscription")
      )
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
