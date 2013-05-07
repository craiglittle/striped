require 'helper'
require 'striped/client'
require 'shared_examples/proxy'

describe Striped::Client do
  let(:api_key)      { 'api_key' }
  let(:api_version)  { 'api_version' }
  subject(:s_client) { Striped::Client.new(api_key, api_version) }

  it_behaves_like 'a proxy' do
    let(:client) { s_client }
  end

  describe "request methods" do
    let(:path)     { 'path' }
    let(:options)  { mock('options') }
    let(:response) { mock('response') }

    before { s_client.stub(:request).and_return(response) }

    [:get, :post, :delete].each do |method|
      describe "#post" do
        before { @response = s_client.send(method, path, options) }

        it "sends the proper request" do
          expect(s_client).to have_received(:request).with(method, path, options)
        end

        it "returns the response" do
          expect(@response).to eq response
        end
      end
    end
  end
end
