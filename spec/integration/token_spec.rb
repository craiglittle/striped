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

  context "when fetching a token" do
    before do
      stub_get_with_auth("/tokens/#{token_id}")
      Striped.token(token_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/tokens/#{token_id}")).to have_been_made
    end
  end
end
