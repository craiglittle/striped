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

  context "when fetching all of the events" do
    before { stub_get_with_auth('/events') }

    context "with the default arguments" do
      before { Striped.event.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/events')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20'} }

      before { Striped.event.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(
          a_get_with_auth('/events').with(body: all_arguments)
        ).to have_been_made
      end
    end
  end
end
