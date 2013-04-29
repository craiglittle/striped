require 'integration/helper'

describe Striped do
  let(:transfer_id) { 'transfer_id' }

  context "when fetching your account details" do
    before do
      stub_get_with_auth('/account')
      Striped.account.fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth('/account')).to have_been_made
    end
  end
end
