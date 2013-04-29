require 'integration/helper'

describe Striped do
  context "when making a request" do
    let(:make_request)    { Striped.charge('charge_id').fetch }
    let(:response_object) { make_request }

    before do
      stub_get_with_auth('/charges/charge_id').to_return(
        body: JSON.dump({amount: 400, card: {expiry: '01/2015'}})
      )
    end

    it "returns an object that accepts method calls to retrieve data" do
      expect(response_object.amount).to eq 400
    end

    it "returns an object that accepts symbol indexing to retrieve data" do
      expect(response_object[:amount]).to eq 400
    end

    it "returns an object that accepts string indexing to retrieve data" do
      expect(response_object['amount']).to eq 400
    end

    it "returns an object in which nested data can be retrieved" do
      expect(response_object.card.expiry).to eq '01/2015'
    end

    context "and an API version" do
      let(:api_version) { '2013-02-13' }

      context "is specified" do
        before do
          Striped.api_version = api_version
          make_request
        end

        after  { Striped.api_version = nil }

        it "adds a Stripe-Version header" do
          expect(
            a_get_with_auth('/charges/charge_id')
              .with(headers: {'Stripe-Version' => api_version})
          ).to have_been_made
        end
      end

      context "is not specified" do
        before { make_request }

        it "does not add a Stripe-Version header" do
          expect(
            a_get_with_auth('/charges/charge_id')
              .with(headers: {'Stripe-Version' => api_version})
          ).not_to have_been_made
        end
      end
    end
  end
end
