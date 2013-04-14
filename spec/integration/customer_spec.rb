require 'integration/helper'

describe Striped do
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
end
