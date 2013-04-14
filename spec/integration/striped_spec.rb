require 'integration/helper'

describe Striped do
  context "when making a request" do
    subject(:response_object) { Striped.charge('charge_id').fetch }

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
  end
end
