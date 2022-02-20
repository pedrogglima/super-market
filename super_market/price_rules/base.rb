# frozen_string_literal: true

module SuperMarket
  class PriceRules
    class Base
      def self.apply(*args, &block)
        new(*args, &block).apply
      end
    end
  end
end
