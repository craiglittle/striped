require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Transfer < Base
      include Striped::Proxy::Operations :fetch
    end
  end
end
