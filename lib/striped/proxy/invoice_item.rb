require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class InvoiceItem < Base
      include Striped::Proxy::Operations :create
    end
  end
end
