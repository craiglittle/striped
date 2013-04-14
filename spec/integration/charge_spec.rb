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

    before do
      stub_post_with_auth('/charges')
      Striped.charge.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/charges').with(body: create_arguments)).to have_been_made
    end
  end

  context "when fetching a charge" do
    let(:charge_id) { 'charge_id' }

    before do
      stub_get_with_auth("/charges/#{charge_id}")
      Striped.charge(charge_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/charges/#{charge_id}")).to have_been_made
    end
  end
end
