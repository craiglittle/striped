require 'helper'
require 'striped/client'

describe Striped::Client do
  let(:api_key)     { 'api_key' }
  let(:api_version) { 'api_version' }
  let(:proxy)       { double('proxy') }
  subject(:client)  { Striped::Client.new(api_key, api_version) }

  describe "#charge" do
    before { Striped::Proxy::Charge.stub(:new).and_return(proxy) }

    it "returns a charge proxy" do
      expect(client.charge).to eq proxy
    end

    it "passes on an optional charge ID" do
      client.charge('charge_id')
      expect(Striped::Proxy::Charge).to have_received(:new).with(client, 'charge_id')
    end
  end

  describe "#customer" do
    before { Striped::Proxy::Customer.stub(:new).and_return(proxy) }

    it "returns a customer proxy" do
      expect(client.customer).to eq proxy
    end

    it "passes on an optional customer ID" do
      client.customer('customer_id')
      expect(Striped::Proxy::Customer).to have_received(:new).with(client, 'customer_id')
    end
  end

  describe "#customer" do
    before { Striped::Proxy::Plan.stub(:new).and_return(proxy) }

    it "returns a customer proxy" do
      expect(client.plan).to eq proxy
    end
  end

  describe "request methods" do
    let(:path)     { 'path' }
    let(:options)  { mock('options') }
    let(:response) { mock('response') }

    before { client.stub(:request).and_return(response) }

    [:get, :post, :delete].each do |method|
      describe "#post" do
        before { @response = client.send(method, path, options) }

        it "sends the proper request" do
          expect(client).to have_received(:request).with(method, path, options)
        end

        it "returns the response" do
          expect(@response).to eq response
        end
      end
    end
  end
end
