shared_examples_for 'a proxy' do
  let(:proxy) { double('proxy') }

  describe "#account" do
    before { Striped::Proxy::Account.stub(:new).and_return(proxy) }

    it "returns a account proxy" do
      expect(client.account).to eq proxy
    end
  end

  [
    [:charge,       Striped::Proxy::Charge],
    [:customer,     Striped::Proxy::Customer],
    [:plan,         Striped::Proxy::Plan],
    [:coupon,       Striped::Proxy::Coupon],
    [:invoice,      Striped::Proxy::Invoice],
    [:invoice_item, Striped::Proxy::InvoiceItem],
    [:transfer,     Striped::Proxy::Transfer],
    [:event,        Striped::Proxy::Event],
    [:token,        Striped::Proxy::Token]
  ].each do |name, klass|
    describe "#{name}" do
      before { klass.stub(:new).and_return(proxy) }

      it "returns a #{name} proxy" do
        expect(client.send(name)).to eq proxy
      end

      it "passes on a resource ID" do
        client.send(name, 'resource_id')
        expect(klass).to have_received(:new).with(client, 'resource_id')
      end
    end
  end
end
