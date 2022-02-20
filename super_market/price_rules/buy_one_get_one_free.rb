# frozen_string_literal: true

module SuperMarket
  class PriceRules
    # Rule: Buy one get one free
    #
    class BuyOneGetOneFree < Base
      def initialize(checkout_item, _opts = {})
        @checkout_item = checkout_item
      end

      # returns discount value
      def apply
        return 0 unless promotion_quantity?

        product = self.class.find(@checkout_item.product_id)

        product.multiply_price(promotion_quantity)
      end

      def self.find(product_id)
        ::SuperMarket::BuyOneGetOneFree.find(product_id)
      end

      def self.product_with_discount?(checkout_item)
        ::SuperMarket::BuyOneGetOneFree.product_with_discount?(checkout_item)
      end

      private

      def promotion_quantity?
        promotion_quantity.positive?
      end

      def divide_by_two
        (@checkout_item.quantity / 2).to_i
      end

      alias promotion_quantity divide_by_two
    end
  end
end
