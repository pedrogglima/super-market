# frozen_string_literal: true

require_relative '../checkout_decorator'
require_relative './checkout/item'

module SuperMarket
  class Checkout
    include CheckoutDecorator

    attr_reader :items, :pricing_rules

    def initialize(pricing_rules)
      @pricing_rules = pricing_rules
      @items = []
    end

    def scan(product_code)
      product = products.find_by(:code, product_code)

      return unless product&.in_stock?

      checkout_item = find_by(:product_code, product_code)

      if checkout_item
        checkout_item << product
      else
        @items << Item.new(product)
      end

      product
    end

    def total_items
      @items.inject(0) { |sum, item| sum + item.quantity }
    end

    def total_amount
      (total_before_discount_amount - total_discount_amount)
    end

    def total_discount_amount
      @items.inject(0) do |sum, item|
        sum + @pricing_rules.apply(item)
      end
    end

    def total_before_discount_amount
      (@items.inject(0) { |sum, item| sum + item.total_price })
    end

    def find(id)
      items.find { |checkout_item| checkout_item.product_id == id }
    end

    def find_by(attr_name, attr_value)
      items.find { |checkout_item| checkout_item.send(attr_name) == attr_value }
    end

    def clear_items
      @items = []
    end

    private

    def products
      Product
    end
  end
end
