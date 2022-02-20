# frozen_string_literal: true

module SuperMarket
  class PriceRules
    # Rule: Apply discount after X items for all items
    #
    class DiscountAfter < Base
      attr_accessor :promotion_threshold

      def initialize(checkout_item, opts = {})
        @checkout_item = checkout_item
        @promotion_threshold = opts.fetch(:discount_after, 3)
      end

      def apply
        return 0 unless promotion_quantity?

        product = self.class.find(@checkout_item.product_id)

        product.discount(promotion_quantity)
      end

      def self.find(product_id)
        ::SuperMarket::DiscountAfter.find(product_id)
      end

      def self.product_with_discount?(checkout_item)
        ::SuperMarket::DiscountAfter.product_with_discount?(checkout_item)
      end

      def promotion_quantity
        @checkout_item.quantity
      end

      def promotion_quantity?
        promotion_quantity >= @promotion_threshold
      end
    end
  end
end
