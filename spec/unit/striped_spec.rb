require 'helper'
require 'striped'

describe Striped do
  context "when calling delegated methods" do
    let(:client) { double('client') }

    before { Striped::Client.stub(:new).and_return(client) }
    after  { Striped.instance_variable_set(:@client, nil) }

    describe "::charge" do
      before do
        client.stub(:charge)
        Striped.charge
      end

      it "delegates to the client" do
        expect(client).to have_received(:charge)
      end
    end
  end
end
