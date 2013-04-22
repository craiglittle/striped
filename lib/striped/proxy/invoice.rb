require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Invoice < Base
      include Striped::Proxy::Operations :create, :fetch, :update
    end
  end
end
