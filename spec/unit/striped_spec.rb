require 'helper'
require 'striped'

describe Striped do
  context "when calling delegated methods" do
    let(:client) { double('client') }

    before { Striped::Client.stub(:new).and_return(client) }
    after  { Striped.instance_variable_set(:@client, nil) }

    describe "::charge" do
      it "delegates to the client" do
        client.should_receive(:charge)
        Striped.charge
      end
    end
  end
end
