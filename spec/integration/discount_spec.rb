require 'integration/helper'

describe Striped do
  let(:customer_id) { 'customer_id' }

  context "when deleting a customer's discount" do
    before do
      stub_delete_with_auth("/customers/#{customer_id}/discount")
      Striped.customer(customer_id).discount.delete
    end

    it "send the proper request to the Stripe API" do
      expect(a_delete_with_auth("/customers/#{customer_id}/discount"))
        .to have_been_made
    end
  end
end
