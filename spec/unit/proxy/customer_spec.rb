require 'helper'
require 'striped/proxy/customer'

describe Striped::Proxy::Customer do
  let(:client)      { double('client') }
  let(:resource)    { 'customers' }
  let(:resource_id) { 'customer_id' }
  subject(:proxy)   { Striped::Proxy::Customer.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :update, :delete, :all

  describe "#subscription" do
    let(:subscription_proxy) { double('proxy') }

    before do
      Striped::Proxy::Subscription.stub(:new).and_return(subscription_proxy)
      @proxy = proxy.subscription
    end

    it "returns a subscription proxy" do
      expect(@proxy).to eq subscription_proxy
    end

    it "is passed the client and customer_id when instantiated" do
      expect(Striped::Proxy::Subscription).to(
        have_received(:new).with(client, resource_id)
      )
    end
  end
end
