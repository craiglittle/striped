require 'integration/helper'

describe Striped do
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
end
