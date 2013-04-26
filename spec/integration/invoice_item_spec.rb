require 'integration/helper'

describe Striped do
  let(:invoice_item_id) { 'invoice_item_id' }

  context "when creating an invoice item" do
    let(:create_arguments) {
      {
        customer:    'cus_1hzlFU4mNuByF5',
        amount:      '1000',
        currency:    'usd',
        description: 'One-time setup fee'
      }
    }

    before do
      stub_post_with_auth('/invoiceitems')
      Striped.invoice_item.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/invoiceitems').with(body: create_arguments))
        .to have_been_made
    end
  end

  context "when fetching an invoice item" do
    before do
      stub_get_with_auth("/invoiceitems/#{invoice_item_id}")
      Striped.invoice_item(invoice_item_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/invoiceitems/#{invoice_item_id}"))
        .to have_been_made
    end
  end

  context "when updating an invoice item" do
    let(:update_arguments) {
      {
        amount:      '1500',
        description: 'Customer for test@example.com'
      }
    }

    before do
      stub_post_with_auth("/invoiceitems/#{invoice_item_id}")
      Striped.invoice_item(invoice_item_id).update(update_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(
        a_post_with_auth("/invoiceitems/#{invoice_item_id}")
          .with(body: update_arguments)
      ).to have_been_made
    end
  end

  context "when deleting an invoice item" do
    before do
      stub_delete_with_auth("/invoiceitems/#{invoice_item_id}")
      Striped.invoice_item(invoice_item_id).delete
    end

    it "sends the proper request to the Stripe API" do
      expect(a_delete_with_auth("/invoiceitems/#{invoice_item_id}"))
        .to have_been_made
    end
  end

  context "when fetching all of the invoice items" do
    before { stub_get_with_auth('/invoiceitems') }

    context "with the default arguments" do
      before { Striped.invoice_item.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/invoiceitems')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20', offset: '40'} }

      before { Striped.invoice_item.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/invoiceitems').with(body: all_arguments))
          .to have_been_made
      end
    end
  end
end
