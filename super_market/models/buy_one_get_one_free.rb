# frozen_string_literal: true

module SuperMarket
  class BuyOneGetOneFree < Base
    extend ProductQueryable

    # This represents a has many relationship using the product ID
    # That means, BuyOneGetOneFree may have many related products
    #
    # 1 - Green tea
    #
    # query database the products with pricing rules
    def self.products
      find_ids([1])
    end
  end
end
