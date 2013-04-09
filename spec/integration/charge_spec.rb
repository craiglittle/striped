require 'integration/helper'

describe Striped do
  context "when creating a charge" do
    let(:arguments) {
      {
        amount:      '400',
        currency:    'usd',
        card:        'tok_C3UDy4Ud3MR0EH',
        description: 'Charge for test@example.com'
      }
    }
    subject(:create_charge) { Striped.charge.create(arguments) }

    it "sends a request to the Stripe API" do
      stub_post_with_auth('/charges')
      create_charge
      expect(a_post_with_auth('/charges').with(body: arguments)).to have_been_made
    end

    it "returns a valid object", :vcr do
      expect(create_charge.amount).to eq 400
    end
  end

  context "when fetching a charge" do
    let(:charge_id) { 'ch_1c9y4KmMtRBLMt' }
    subject(:fetch_charge) { Striped.charge(charge_id).fetch }

    it "sends a request to the Stripe API" do
      stub_get_with_auth('/charges')
      fetch_charge
      expect(a_get_with_auth("/charges/#{charge_id}")).to have_been_made
    end

    it "returns a valid object", :vcr do
      expect(fetch_charge.paid).to eq true
    end
  end
end
