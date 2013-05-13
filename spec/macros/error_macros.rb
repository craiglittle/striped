module ErrorMacros

  def self.included(base)
    base.extend Macros
  end

  module Macros

    def it_inherits_from_the_proper_error(error_classes, parent_class)
      error_classes.each do |error_class|
        specify do
          expect { raise error_class }.to raise_error parent_class
        end
      end
    end

  end
end
