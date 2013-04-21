require 'striped/proxy/base'
require 'striped/proxy/operations'

module Striped
  module Proxy
    class Plan < Base
      include Striped::Proxy::Operations :create, :fetch, :update, :delete, :all
    end
  end
end
