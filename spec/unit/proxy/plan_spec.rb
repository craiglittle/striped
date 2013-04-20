require 'helper'
require 'striped/proxy/plan'

describe Striped::Proxy::Plan do
  let(:client)             { double('client') }
  let(:plan_id)            { 'plan_id' }
  let(:api_response)       { double('API response') }
  let(:arguments)          { double('arguments') }
  subject(:plan_proxy)     { Striped::Proxy::Plan.new(client, plan_id) }

  before do
    [:get, :post, :delete].each do |method|
      client.stub(method).and_return(api_response)
    end
  end

  describe "#create" do
    before { @response = plan_proxy.create(arguments) }

    it "sends a request to create a plan" do
      expect(client).to have_received(:post).with('/plans', body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#fetch" do
    before { @response = plan_proxy.fetch }

    it "sends a request to fetch a plan" do
      expect(client).to have_received(:get).with("/plans/#{plan_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#update" do
    before { @response = plan_proxy.update(arguments) }

    it "sends a request to update a plan" do
      expect(client).to have_received(:post).with("/plans/#{plan_id}", body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#delete" do
    before { @response = plan_proxy.delete }

    it "sends a request to delete a plan" do
      expect(client).to have_received(:delete).with("/plans/#{plan_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end
end
