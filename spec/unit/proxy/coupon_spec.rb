require 'helper'
require 'striped/proxy/coupon'

describe Striped::Proxy::Coupon do
  let(:client)      { double('client') }
  let(:resource)    { 'coupons' }
  let(:resource_id) { 'coupon_id' }
  subject(:proxy)   { Striped::Proxy::Coupon.new(client, resource_id) }

  it_executes_a_valid_operation :create, :fetch, :delete, :all
end
