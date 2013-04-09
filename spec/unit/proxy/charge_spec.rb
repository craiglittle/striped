require 'helper'
require 'striped/proxy/charge'

describe Striped::Proxy::Charge do
  let(:client)           { double('client') }
  let(:api_response)     { double('API response') }
  let(:arguments)        { double('arguments') }
  subject(:change_proxy) { Striped::Proxy::Charge.new(client) }

  before do
    client.stub(:get).and_return(api_response)
    client.stub(:post).and_return(api_response)
  end

  describe "#create" do
    it "sends a request to create a charge" do
      client.should_receive(:post).with('/charges', body: arguments)
      change_proxy.create(arguments)
    end

    it "returns the API response" do
      expect(change_proxy.create(arguments)).to eq api_response
    end
  end
end
