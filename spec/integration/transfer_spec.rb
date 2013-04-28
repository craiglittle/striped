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
end
