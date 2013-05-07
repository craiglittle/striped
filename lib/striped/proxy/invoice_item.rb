require 'striped/proxy/base'
require 'striped/api/operations'

module Striped
  module Proxy
    class InvoiceItem < Base
      include Striped::API::Operations :create, :fetch, :update, :delete, :all
    end
  end
end
