require 'helper'
require 'striped/proxy/charge'

describe Striped::Proxy::Charge do
  let(:client)           { double('client') }
  let(:charge_id)        { 'charge_id' }
  let(:api_response)     { double('API response') }
  let(:arguments)        { double('arguments') }
  subject(:change_proxy) { Striped::Proxy::Charge.new(client, charge_id) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  describe "#create" do
    before { @response = change_proxy.create(arguments) }

    it "sends a request to create a charge" do
      expect(client).to have_received(:post).with('/charges', body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#fetch" do
    before { @response = change_proxy.fetch }

    it "sends a request to fetch a charge" do
      expect(client).to have_received(:get).with("/charges/#{charge_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
