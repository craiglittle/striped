require 'integration/helper'

describe Striped do
  let(:transfer_id) { 'transfer_id' }

  context "when fetching a transfer" do
    before do
      stub_get_with_auth("/transfers/#{transfer_id}")
      Striped.transfer(transfer_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/transfers/#{transfer_id}")).to have_been_made
    end
  end

  context "when fetching all of the transfers" do
    before { stub_get_with_auth('/transfers') }

    context "with the default arguments" do
      before { Striped.transfer.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/transfers')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20'} }

      before { Striped.transfer.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(
          a_get_with_auth('/transfers').with(body: all_arguments)
        ).to have_been_made
      end
    end
  end
end
