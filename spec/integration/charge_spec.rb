require 'integration/helper'

describe Striped do
  context "when creating a charge" do
    let(:create_arguments) {
      {
        amount:      '400',
        currency:    'usd',
        card:        'tok_C3UDy4Ud3MR0EH',
        description: 'Charge for test@example.com'
      }
    }
    subject(:create_charge) { Striped.charge.create(create_arguments) }

    before do
      stub_post_with_auth('/charges').to_return(body: JSON.dump({amount: 400}))
      create_charge
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/charges').with(body: create_arguments)).to have_been_made
    end

    it "returns a valid object" do
      expect(create_charge.amount).to eq 400
    end
  end

  context "when fetching a charge" do
    before { Striped.charge('charge_id').fetch }

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/charges/charge_id")).to have_been_made
    end
  end
end
