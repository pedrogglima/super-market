# frozen_string_literal: true

module SuperMarket
  class Product < Base
    extend ProductQueryable

    field :id, :integer
    field :code, :string
    field :name, :string
    field :quantity, :integer
    field :price, :bigdecimal
    field :discount_value, :bigdecimal, default: 0
    field :discount_type, :string, default: 'V'

    def initialize(attrs)
      # change attrs type, check presence, apply default value, etc.
      attrs = self.class.normalize(attrs)

      attrs.each do |k, v|
        self.class.class_eval { attr_accessor k.to_s }
        instance_variable_set("@#{k}", v)
      end
    end

    def in_stock?(quantity = 1)
      @quantity.positive? && quantity <= @quantity
    end

    def percentual_discount?
      discount_type == 'P'
    end

    def discount(quantity = 1)
      amount = if percentual_discount?
                 (price * (discount_value / BigDecimal('100')))
               else
                 discount_value
               end

      (amount * quantity).round(2)
    end

    def multiply_price(quantity = 1)
      (price * quantity).round(2)
    end
  end
end
