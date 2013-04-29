require 'integration/helper'

describe Striped do
  let(:token_id) { 'token_id' }

  context "when creating a token" do
    let(:create_arguments) {
      {
        card: {
          number:    '4242424242424242',
          exp_month: '12',
          exp_year:  '2014',
          cvc:       '123'
        }
      }
    }

    before do
      stub_post_with_auth('/tokens')
      Striped.token.create(create_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth('/tokens').with(body: create_arguments)).to have_been_made
    end
  end
end
