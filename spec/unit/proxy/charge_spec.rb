require 'helper'
require 'striped/proxy/charge'

describe Striped::Proxy::Charge do
  let(:client)      { double('client') }
  let(:resource)    { 'charges' }
  let(:resource_id) { 'charge_id' }
  subject(:proxy)   { Striped::Proxy::Charge.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :all

  before { client.stub(:post).and_return(api_response) }

  describe "#refund" do
    context "when refunding the entire amount" do
      before { @response = proxy.refund }

      it "sends a request to refund the charge" do
        expect(client).to(
          have_received(:post).with("/charges/#{resource_id}/refund", body: nil)
        )
      end

      it_returns_the_api_response
    end

    context "when refunding a partial amount" do
      before { @response = proxy.refund(arguments) }

      it "sends a request to refund a part of the charge" do
        expect(client).to(
          have_received(:post)
            .with("/charges/#{resource_id}/refund", body: arguments)
        )
      end
    end
  end

  describe "#capture" do
    context "with the default arguments" do
      before { @response = proxy.capture }

      it "sends a request to capture the charge" do
        expect(client).to(
          have_received(:post)
            .with("/charges/#{resource_id}/capture", body: nil)
        )
      end

      it_returns_the_api_response
    end

    context "with additional arguments" do
      before { @response = proxy.capture(arguments) }

      it "sends a request to capture the charge" do
        expect(client).to(
          have_received(:post)
            .with("/charges/#{resource_id}/capture", body: arguments)
        )
      end
    end
  end
end
