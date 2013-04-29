require 'integration/helper'

describe Striped do
  let(:event_id) { 'event_id' }

  context "when fetching a event" do
    before do
      stub_get_with_auth("/events/#{event_id}")
      Striped.event(event_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/events/#{event_id}")).to have_been_made
    end
  end
end
