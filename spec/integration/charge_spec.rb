require 'integration/helper'

describe Striped do
  let(:charge_id) { 'charge_id' }

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
    before do
      stub_get_with_auth("/charges/#{charge_id}")
      Striped.charge(charge_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/charges/#{charge_id}")).to have_been_made
    end
  end

  context "when refunding a charge" do
    before { stub_post_with_auth("/charges/#{charge_id}/refund") }

    context "for the entire amount" do
      before { Striped.charge(charge_id).refund }

      it "sends the proper request to the Stripe API" do
        expect(a_post_with_auth("/charges/#{charge_id}/refund")).to have_been_made
      end
    end

    context "for a partial amount" do
      let(:refund_arguments) { {amount: '1000'} }

      before { Striped.charge(charge_id).refund(refund_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_post_with_auth("/charges/#{charge_id}/refund").with(body: refund_arguments)).to have_been_made
      end
    end
  end

  context "when capturing a charge" do
    before { stub_post_with_auth("/charges/#{charge_id}/capture") }

    context "with the default arguments" do
      before { Striped.charge(charge_id).capture }

      it "sends the proper request to the Stripe API" do
        expect(a_post_with_auth("/charges/#{charge_id}/capture")).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:capture_arguments) { {amount: '1000', application_fee: '500'} }

      before { Striped.charge(charge_id).capture(capture_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_post_with_auth("/charges/#{charge_id}/capture").with(body: capture_arguments)).to have_been_made
      end
    end
  end

  context "when fetching all of the charges" do
    before { stub_get_with_auth("/charges") }

    context "with the default arguments" do
      before { Striped.charge.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth("/charges")).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20', customer: 'customer_id'} }

      before { Striped.charge.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth("/charges").with(body: all_arguments)).to have_been_made
      end
    end
  end
end
