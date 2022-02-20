# frozen_string_literal: true

module SuperMarket
  class DiscountAfter < Base
    extend ProductQueryable

    # This represents a has many relationship using the product ID
    # That means, DiscountAfter may have many related products
    #
    # 2 - Strawberries
    # 3 - Coffee
    #
    # query database the products with pricing rules
    def self.products
      find_ids([2, 3])
    end
  end
end
