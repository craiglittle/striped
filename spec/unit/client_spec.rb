require 'helper'
require 'striped/client'

describe Striped::Client do
  let(:api_key)     { mock('API key') }
  let(:api_version) { mock('API version') }
  let(:proxy)       { double('proxy') }
  subject(:client)  { Striped::Client.new(api_key, api_version) }

  describe "#charge" do
    it "returns a charge proxy" do
      Striped::Proxy::Charge.should_receive(:new).with(client).and_return(proxy)
      expect(client.charge).to eq proxy
    end
  end

  describe "request methods" do
    let(:path)     { mock('path') }
    let(:options)  { mock('options') }
    let(:response) { mock('response') }

    before { client.stub(:request).and_return(response) }

    describe "#post" do
      it "sends the proper request" do
        client.should_receive(:request).with(:post, path, options)
        client.post(path, options)
      end

      it "returns the response" do
        expect(client.post(path, options)).to eq response
      end
    end
  end
end
