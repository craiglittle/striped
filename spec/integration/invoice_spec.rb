require 'integration/helper'

describe Striped do
  let(:invoice_id) { 'invoice_id' }

  context "when creating an invoice" do
    let(:create_arguments) { {customer: 'cus_1gTQyX0MXWWW5d'} }

    before do
      stub_post_with_auth('/invoices')
      Striped.invoice.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/invoices').with(body: create_arguments))
        .to have_been_made
    end
  end

  context "when fetching an invoice" do
    before do
      stub_get_with_auth("/invoices/#{invoice_id}")
      Striped.invoice(invoice_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/invoices/#{invoice_id}")).to have_been_made
    end
  end

  context "when updating an invoice" do
    let(:update_arguments) { {closed: 'true'} }

    before do
      stub_post_with_auth("/invoices/#{invoice_id}")
      Striped.invoice(invoice_id).update(update_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth("/invoices/#{invoice_id}").with(body: update_arguments))
        .to have_been_made
    end
  end

  context "when fetching all of the invoices" do
    before { stub_get_with_auth('/invoices') }

    context "with the default arguments" do
      before { Striped.invoice.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/invoices')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20', offset: '40'} }

      before { Striped.invoice.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/invoices').with(body: all_arguments)).to have_been_made
      end
    end
  end

  context "when paying an invoice" do
    before do
      stub_post_with_auth("/invoices/#{invoice_id}/pay")
      Striped.invoice(invoice_id).pay
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth("/invoices/#{invoice_id}/pay")).to have_been_made
    end
  end
end
