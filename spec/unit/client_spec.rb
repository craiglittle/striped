require 'helper'
require 'striped/client'

describe Striped::Client do
  let(:api_key)     { 'api_key' }
  let(:api_version) { 'api_version' }
  let(:proxy)       { double('proxy') }
  subject(:client)  { Striped::Client.new(api_key, api_version) }

  describe "#charge" do
    before { Striped::Proxy::Charge.stub(:new).and_return(proxy) }

    it "returns a charge proxy" do
      expect(client.charge).to eq proxy
    end

    it "passes on an optional charge ID" do
      client.charge('charge_id')
      expect(Striped::Proxy::Charge).to have_received(:new).with(client, 'charge_id')
    end
  end

  describe "#customer" do
    before { Striped::Proxy::Customer.stub(:new).and_return(proxy) }

    it "returns a customer proxy" do
      expect(client.customer).to eq proxy
    end

    it "passes on an optional customer ID" do
      client.customer('customer_id')
      expect(Striped::Proxy::Customer).to have_received(:new).with(client, 'customer_id')
    end
  end

  describe "#plan" do
    before { Striped::Proxy::Plan.stub(:new).and_return(proxy) }

    it "returns a plan proxy" do
      expect(client.plan).to eq proxy
    end

    it "passes on an optional plan ID" do
      client.plan('plan_id')
      expect(Striped::Proxy::Plan).to have_received(:new).with(client, 'plan_id')
    end
  end

  describe "#coupon" do
    before { Striped::Proxy::Coupon.stub(:new).and_return(proxy) }

    it "returns a coupon proxy" do
      expect(client.coupon).to eq proxy
    end

    it "passes on an optional coupon ID" do
      client.coupon('coupon_id')
      expect(Striped::Proxy::Coupon).to have_received(:new).with(client, 'coupon_id')
    end
  end

  describe "#invoice" do
    before { Striped::Proxy::Invoice.stub(:new).and_return(proxy) }

    it "returns a invoice proxy" do
      expect(client.invoice).to eq proxy
    end

    it "passes on an optional invoice ID" do
      client.invoice('invoice_id')
      expect(Striped::Proxy::Invoice).to have_received(:new).with(client, 'invoice_id')
    end
  end

  describe "#invoice_item" do
    before { Striped::Proxy::InvoiceItem.stub(:new).and_return(proxy) }

    it "returns a invoice proxy" do
      expect(client.invoice_item).to eq proxy
    end

    it "passes on an optional invoice ID" do
      client.invoice_item('invoice_item_id')
      expect(Striped::Proxy::InvoiceItem).to(
        have_received(:new).with(client, 'invoice_item_id')
      )
    end
  end

  describe "#transfer" do
    before { Striped::Proxy::Transfer.stub(:new).and_return(proxy) }

    it "returns a transfer proxy" do
      expect(client.transfer).to eq proxy
    end

    it "passes on an optional transfer ID" do
      client.transfer('transfer_id')
      expect(Striped::Proxy::Transfer).to(
        have_received(:new).with(client, 'transfer_id')
      )
    end
  end

  describe "#account" do
    before { Striped::Proxy::Account.stub(:new).and_return(proxy) }

    it "returns a account proxy" do
      expect(client.account).to eq proxy
    end
  end

  describe "#event" do
    before { Striped::Proxy::Event.stub(:new).and_return(proxy) }

    it "returns a event proxy" do
      expect(client.event).to eq proxy
    end

    it "passes on an optional event ID" do
      client.event('event_id')
      expect(Striped::Proxy::Event).to(
        have_received(:new).with(client, 'event_id')
      )
    end
  end

  describe "request methods" do
    let(:path)     { 'path' }
    let(:options)  { mock('options') }
    let(:response) { mock('response') }

    before { client.stub(:request).and_return(response) }

    [:get, :post, :delete].each do |method|
      describe "#post" do
        before { @response = client.send(method, path, options) }

        it "sends the proper request" do
          expect(client).to have_received(:request).with(method, path, options)
        end

        it "returns the response" do
          expect(@response).to eq response
        end
      end
    end
  end
end
