require 'helper'
require 'striped/proxy/charge'

describe Striped::Proxy::Charge do
  let(:client)           { double('client') }
  let(:charge_id)        { 'charge_id' }
  let(:api_response)     { double('API response') }
  let(:arguments)        { double('arguments') }
  subject(:charge_proxy) { Striped::Proxy::Charge.new(client, charge_id) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  describe "#create" do
    before { @response = charge_proxy.create(arguments) }

    it "sends a request to create a charge" do
      expect(client).to have_received(:post).with('/charges', body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#fetch" do
    before { @response = charge_proxy.fetch }

    it "sends a request to fetch a charge" do
      expect(client).to have_received(:get).with("/charges/#{charge_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#refund" do
    context "when refunding the entire amount" do
      before { @response = charge_proxy.refund }

      it "sends a request to refund the charge" do
        expect(client).to have_received(:post).with("/charges/#{charge_id}/refund", body: nil)
      end

      it "returns the API response" do
        expect(@response).to eq api_response
      end
    end

    context "when refunding a partial amount" do
      before { @response = charge_proxy.refund(arguments) }

      it "sends a request to refund a part of the charge" do
        expect(client).to have_received(:post).with("/charges/#{charge_id}/refund", body: arguments)
      end
    end
  end
end
