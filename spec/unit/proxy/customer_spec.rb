require 'helper'
require 'striped/proxy/customer'

describe Striped::Proxy::Customer do
  let(:client)             { double('client') }
  let(:customer_id)        { 'customer_id' }
  let(:api_response)       { double('API response') }
  let(:arguments)          { double('arguments') }
  subject(:customer_proxy) { Striped::Proxy::Customer.new(client, customer_id) }

  before do
    [:get, :post, :delete].each do |method|
      client.stub(method).and_return(api_response)
    end
  end

  describe "#subscription" do
    let(:proxy) { double('proxy') }

    before do
      Striped::Proxy::Subscription.stub(:new).and_return(proxy)
      @proxy = customer_proxy.subscription
    end

    it "returns a subscription proxy" do
      expect(@proxy).to eq proxy
    end

    it "is passed the client and customer_id when instantiated" do
      expect(Striped::Proxy::Subscription).to have_received(:new).with(client, 'customer_id')
    end
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

  describe "#fetch" do
    before { @response = customer_proxy.fetch }

    it "sends a request to fetch a customer" do
      expect(client).to have_received(:get).with("/customers/#{customer_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#update" do
    before { @response = customer_proxy.update(arguments) }

    it "sends a request to update a customer" do
      expect(client).to have_received(:post).with("/customers/#{customer_id}", body: arguments)
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#delete" do
    before { @response = customer_proxy.delete }

    it "sends a request to fetch a customer" do
      expect(client).to have_received(:delete).with("/customers/#{customer_id}")
    end

    it "returns the API response" do
      expect(@response).to eq api_response
    end
  end

  describe "#all" do
    context "with the default arguments" do
      before { @response = customer_proxy.all }

      it "sends a request to capture the customer" do
        expect(client).to have_received(:get).with('/customers', body: nil)
      end

      it "returns the API response" do
        expect(@response).to eq api_response
      end
    end

    context "with additional arguments" do
      before { @response = customer_proxy.all(arguments) }

      it "sends a request to capture the customer" do
        expect(client).to have_received(:get).with('/customers', body: arguments)
      end
    end
  end
end
