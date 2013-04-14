require 'integration/helper'

describe Striped do
  let(:customer_id) { 'customer_id' }

  context "when creating a customer" do
    let(:create_arguments) {
      {
        number: '1234567890123456',
        exp_month: '01',
        exp_year: '17'
      }
    }

    before do
      stub_post_with_auth('/customers')
      Striped.customer.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/customers').with(body: create_arguments)).to have_been_made
    end
  end

  context "when fetching a customer" do
    before do
      stub_get_with_auth("/customers/#{customer_id}")
      Striped.customer(customer_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/customers/#{customer_id}")).to have_been_made
    end
  end

  context "when updating a customer" do
    let(:update_arguments) { {coupon: 'coupon_code', account_balance: '50000'} }

    before do
      stub_post_with_auth("/customers/#{customer_id}")
      Striped.customer(customer_id).update(update_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth("/customers/#{customer_id}").with(body: update_arguments)).to have_been_made
    end
  end
end
