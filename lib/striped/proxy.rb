require 'striped/proxy/charge'
require 'striped/proxy/customer'
require 'striped/proxy/plan'
require 'striped/proxy/coupon'
require 'striped/proxy/invoice'
require 'striped/proxy/invoice_item'
require 'striped/proxy/transfer'
require 'striped/proxy/account'
require 'striped/proxy/event'
require 'striped/proxy/token'

module Striped
  module Proxy

    def charge(charge_id = nil)
      Striped::Proxy::Charge.new(self, charge_id)
    end

    def customer(customer_id = nil)
      Striped::Proxy::Customer.new(self, customer_id)
    end

    def plan(plan_id = nil)
      Striped::Proxy::Plan.new(self, plan_id)
    end

    def coupon(coupon_id = nil)
      Striped::Proxy::Coupon.new(self, coupon_id)
    end

    def invoice(invoice_id = nil)
      Striped::Proxy::Invoice.new(self, invoice_id)
    end

    def invoice_item(invoice_item_id = nil)
      Striped::Proxy::InvoiceItem.new(self, invoice_item_id)
    end

    def transfer(transfer_id = nil)
      Striped::Proxy::Transfer.new(self, transfer_id)
    end

    def account
      Striped::Proxy::Account.new(self)
    end

    def event(event_id = nil)
      Striped::Proxy::Event.new(self, event_id)
    end

    def token(token_id = nil)
      Striped::Proxy::Token.new(self, token_id)
    end

  end
end
