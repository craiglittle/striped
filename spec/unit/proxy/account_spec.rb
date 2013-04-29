require 'helper'
require 'striped/proxy/account'

describe Striped::Proxy::Account do
  let(:client)       { double('client') }
  let(:resource)     { 'account' }
  let(:resource_id)  { nil }
  let(:api_response) { double('API response') }
  subject(:proxy)    { Striped::Proxy::Account.new(client, resource_id) }

  before { client.stub(:get).and_return(api_response) }

  describe "#fetch" do
    before { proxy.fetch }

    it "sends a request to fetch your account details" do
      expect(client).to have_received(:get).with('/account')
    end
  end
end

