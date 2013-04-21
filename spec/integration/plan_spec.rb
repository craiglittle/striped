require 'integration/helper'

describe Striped do
  let(:plan_id) { 'plan_id' }

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
      expect(a_post_with_auth('/plans').with(body: create_arguments))
        .to have_been_made
    end
  end

  context "when fetching a plan" do
    before do
      stub_get_with_auth("/plans/#{plan_id}")
      Striped.plan(plan_id).fetch
    end

    it "sends the proper request to the Stripe API" do
      expect(a_get_with_auth("/plans/#{plan_id}")).to have_been_made
    end
  end

  context "when updating a plan" do
    let(:update_arguments) { {name: 'New name'} }

    before do
      stub_post_with_auth("/plans/#{plan_id}")
      Striped.plan(plan_id).update(update_arguments)
    end

    it "sends the proper request to the Stripe API" do
      expect(a_post_with_auth("/plans/#{plan_id}").with(body: update_arguments))
        .to have_been_made
    end
  end

  context "when deleting a plan" do
    before do
      stub_delete_with_auth("/plans/#{plan_id}")
      Striped.plan(plan_id).delete
    end

    it "sends the proper request to the Stripe API" do
      expect(a_delete_with_auth("/plans/#{plan_id}")).to have_been_made
    end
  end

  context "when fetching all of the plans" do
    before { stub_get_with_auth('/plans') }

    context "with the default arguments" do
      before { Striped.plan.all }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/plans')).to have_been_made
      end
    end

    context "with additional arguments" do
      let(:all_arguments) { {count: '20', offset: '40'} }

      before { Striped.plan.all(all_arguments) }

      it "sends the proper request to the Stripe API" do
        expect(a_get_with_auth('/plans').with(body: all_arguments)).to have_been_made
      end
    end
  end
end
