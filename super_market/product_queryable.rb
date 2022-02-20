# frozen_string_literal: true

require 'csv'

module SuperMarket
  module ProductQueryable
    def all
      @products = []
      CSV.foreach(File.join(File.dirname(__FILE__), '../data/products.csv'), headers: true) do |row|
        @products << Product.new({
                                   name: row['name'],
                                   price: row['price'],
                                   quantity: row['quantity'],
                                   id: row['id'],
                                   code: row['code'],
                                   discount_value: row['discount_value'],
                                   discount_type: row['discount_type']
                                 })
      end

      @products
    end

    def find(id)
      all.find { |product| product.id == id }
    end

    def find_by(attr_name, attr_value)
      all.find { |product| product.send(attr_name) == attr_value }
    end

    def find_ids(ids)
      all.select { |product| ids.include?(product.id) }
    end

    def product_with_discount?(checkout_item)
      products.any? { |product| product.id == checkout_item.product_id }
    end
  end
end
