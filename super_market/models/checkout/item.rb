# frozen_string_literal: true

require 'forwardable'

module SuperMarket
  class Checkout
    class Item
      extend Forwardable
      delegate [:<<] => :@products

      attr_reader :products, :product_id, :product_code

      def initialize(product)
        @product_id = product.id
        @product_code = product.code
        @products = [product]
      end

      def quantity
        @products.length
      end

      def total_price
        product_price * quantity
      end

      def product_price
        @products.first.price
      end

      def product_discount
        @products.first.discount_value
      end
    end
  end
end
