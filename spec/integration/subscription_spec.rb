require 'integration/helper'

describe Striped do
  let(:customer_id) { 'customer_id' }

  context "when updating a customer's subscription" do
    let(:update_arguments) { {plan: 'plan_id', coupon: 'coupon_code'} }

    before do
      stub_post_with_auth("/customers/#{customer_id}/subscription")
      Striped.customer(customer_id).subscription.update(update_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth("/customers/#{customer_id}/subscription").with(body: update_arguments)).to have_been_made
    end
  end
end
