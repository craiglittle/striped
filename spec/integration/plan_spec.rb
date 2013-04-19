require 'integration/helper'

describe Striped do
  context "when creating a plan" do
    let(:create_arguments) {
      {
        amount:   '2000',
        interval: 'month',
        name:     'Amazing Gold Plan',
        currency: 'usd',
        id:       'gold'
      }
    }

    before do
      stub_post_with_auth('/plans')
      Striped.plan.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/plans').with(body: create_arguments)).to have_been_made
    end
  end
end
