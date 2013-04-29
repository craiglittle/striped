require 'hashie'
require 'pp'

module Striped
  class Object < Hashie::Mash

    def inspect
      pretty_inspect
    end

  end
end
