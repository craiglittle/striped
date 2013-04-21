require 'integration/helper'

describe Striped do
  let(:coupon_id) { 'coupon_id' }

  context "when creating a coupon" do
    let(:create_arguments) {
      {
        percent_off: '25',
        duration: 'repeating',
        duration_in_months: '3',
        id:                 '25OFF'
      }
    }

    before do
      stub_post_with_auth('/coupons')
      Striped.coupon.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/coupons').with(body: create_arguments))
        .to have_been_made
    end
  end

  context "when fetching a coupon" do
    before do
      stub_get_with_auth("/coupons/#{coupon_id}")
      Striped.coupon(coupon_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/coupons/#{coupon_id}")).to have_been_made
    end
  end

  context "when deleting a coupon" do
    before do
      stub_delete_with_auth("/coupons/#{coupon_id}")
      Striped.coupon(coupon_id).delete
    end

    it "sends the proper request to the Stripe API" do
      expect(a_delete_with_auth("/coupons/#{coupon_id}")).to have_been_made
    end
  end

  context "when fetching all of the coupons" do
    before { stub_get_with_auth('/coupons') }

    context "with the default arguments" do
      before { Striped.coupon.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/coupons')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20', offset: '40'} }

      before { Striped.coupon.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/coupons').with(body: all_arguments)).to have_been_made
      end
    end
  end
end
