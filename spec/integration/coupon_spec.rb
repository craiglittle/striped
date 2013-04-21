require 'integration/helper'

describe Striped do
  context "when creating a plan" do
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
end
