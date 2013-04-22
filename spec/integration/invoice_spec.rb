require 'integration/helper'

describe Striped do
  let(:invoice_id) { 'invoice_id' }

  context "when creating an invoice" do
    let(:create_arguments) {
      {
        customer: 'cus_1gTQyX0MXWWW5d'
      }
    }

    before do
      stub_post_with_auth('/invoices')
      Striped.invoice.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/invoices').with(body: create_arguments))
        .to have_been_made
    end
  end

  context "when fetching a invoice" do
    before do
      stub_get_with_auth("/invoices/#{invoice_id}")
      Striped.invoice(invoice_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/invoices/#{invoice_id}")).to have_been_made
    end
  end
end
