require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Coupon < Base
      include Striped::Proxy::Operations :create, :fetch
    end
  end
end
