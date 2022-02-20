# frozen_string_literal: true

require 'money'

module SuperMarket
  module CheckoutDecorator
    def total
      Money.from_amount(total_amount.to_f.round(2), 'GBP').format
    end

    def total_discount
      Money.from_amount(total_discount_amount.to_f.round(2), 'GBP').format
    end

    def total_before_discount
      Money.from_amount(total_before_discount_amount.to_f.round(2), 'GBP').format
    end
  end
end
