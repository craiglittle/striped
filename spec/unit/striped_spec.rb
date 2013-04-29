require 'helper'
require 'striped'

describe Striped do
  context "when calling delegated methods" do
    let(:client) { double('client') }

    before { Striped::Client.stub(:new).and_return(client) }
    after  { Striped.instance_variable_set(:@client, nil) }

    [
      :charge,
      :customer,
      :plan, :coupon,
      :invoice,
      :invoice_item,
      :transfer,
      :account,
      :event,
      :token
    ].each do |resource|
      describe "::#{resource}" do
        before do
          client.stub(resource)
          Striped.send(resource)
        end

        it "delegates to the client" do
          expect(client).to have_received(resource)
        end
      end
    end
  end
end
