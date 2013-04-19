require 'helper'
require 'striped/proxy/plan'

describe Striped::Proxy::Plan do
  let(:client)             { double('client') }
  let(:api_response)       { double('API response') }
  let(:arguments)          { double('arguments') }
  subject(:plan_proxy)     { Striped::Proxy::Plan.new(client) }

  before do
    [:post].each do |method|
      client.stub(method).and_return(api_response)
    end
  end

  describe "#create" do
    before { @response = plan_proxy.create(arguments) }

    it "sends a request to create a customer" do
      expect(client).to have_received(:post).with('/plans', body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
