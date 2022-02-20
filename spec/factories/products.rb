# frozen_string_literal: true

FactoryBot.define do
  factory :product, class: Hash do
    id { 1 }
    code { 'GR1' }
    name { 'Green Tea' }
    price { 3.11 }
    quantity { 5 }
    discount_value { 0 }
    discount_type { 'V' }

    trait :percentual_discount do
      discount_type { 'P' }
    end
  end

  factory :product_instance, class: SuperMarket::Product do
    id { 1 }
    code { 'GR1' }
    name { 'Green Tea' }
    price { 3.11 }
    quantity { 100 }
    discount_value { 0 }
    discount_type { 'V' }

    initialize_with { new(attributes) }

    trait :gr1 do
      id { 1 }
      code { 'GR1' }
      name { 'Green Tea' }
      price { 3.11 }
      quantity { 100 }
      discount_value { 0 }
      discount_type { 'V' }
    end

    trait :sr1 do
      id { 2 }
      code { 'SR1' }
      name { 'Straberries' }
      price { 5.0 }
      quantity { 5 }
      discount_value { 0.5 }
      discount_type { 'V' }
    end

    trait :cf1 do
      id { 3 }
      code { 'CF1' }
      name { 'Coffee' }
      price { 11.23 }
      quantity { 5 }
      discount_value { 33.33 }
      discount_type { 'P' }
    end

    trait :without_discount do
      id { 4 }
      code { 'PR1' }
      name { 'Potatos' }
      price { 2.25 }
      quantity { 0 }
      discount_value { 0.0 }
      discount_type { 'V' }
    end

    trait :out_stock do
      id { 4 }
      code { 'PR1' }
      name { 'Potatos' }
      price { 2.25 }
      quantity { 0 }
      discount_value { 0.0 }
      discount_type { 'V' }
    end

    trait :percentual_discount do
      discount_type { 'P' }
    end
  end

  factory :products_from_csv, class: Array do
    products = [
      SuperMarket::Product.new({
                                 id: 1,
                                 name: 'Green Tea',
                                 code: 'GR1',
                                 price: 3.11,
                                 quantity: 100,
                                 discount_value: nil,
                                 discount_type: nil
                               }),
      SuperMarket::Product.new({
                                 id: 2,
                                 name: 'Strawberries',
                                 code: 'SR1',
                                 price: 5.00,
                                 quantity: 100,
                                 discount_value: 0.5,
                                 discount_type: 'V'
                               }),
      SuperMarket::Product.new({
                                 id: 3,
                                 name: 'Coffee',
                                 code: 'CF1',
                                 price: 11.23,
                                 quantity: 100,
                                 discount_value: 33.33,
                                 discount_type: 'P'
                               }),
      SuperMarket::Product.new({
                                 id: 4,
                                 name: 'Potatos',
                                 code: 'PR1',
                                 price: 2.25,
                                 quantity: 0,
                                 discount_value: 0,
                                 discount_type: 'V'
                               })
    ]

    initialize_with { products }
  end
end
