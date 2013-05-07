require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class Coupon < Base
      include Striped::API::Operations :create, :fetch, :delete, :all
    end
  end
end
