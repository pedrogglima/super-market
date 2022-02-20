# frozen_string_literal: true

require_relative './price_rules/base'
require_relative './price_rules/buy_one_get_one_free'
require_relative './price_rules/discount_after'

module SuperMarket
  class PriceRules
    class << self
      attr_reader :rules

      def rule(name, opts = {})
        @rules[name] = opts
      end
    end

    @rules = {}

    rule :buy_one_get_one_free,
         class_name: 'SuperMarket::PriceRules::BuyOneGetOneFree'

    rule :discount_after,
         class_name: 'SuperMarket::PriceRules::DiscountAfter',
         discount_after: 3

    def apply(item)
      self.class.rules.inject(0) do |sum, (_k, rule)|
        rule_class = rule[:class_name].constantize
        sum += rule_class.apply(item, rule) if rule_class.product_with_discount?(item)

        sum
      end
    end
  end
end
