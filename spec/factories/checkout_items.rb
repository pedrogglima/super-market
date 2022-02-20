# frozen_string_literal: true

FactoryBot.define do
  factory :checkout_items, class: SuperMarket::Checkout::Item do
    initialize_with { new(build(:product_instance, discount_type: 'V')) }

    transient do
      quantity { 1 }
    end

    after(:build) do |checkout_item, evaluator|
      # @note: fix for the one item create on the first call
      quantity = evaluator.quantity - 1

      quantity.times do
        checkout_item << build(:product_instance, discount_type: 'V')
      end
    end
  end

  factory :checkout_items_gr1, class: SuperMarket::Checkout::Item do
    initialize_with { new(build(:product_instance, :gr1)) }

    transient do
      quantity { 1 }
    end

    after(:build) do |checkout_item, evaluator|
      # @note: fix for the one item create on the first call
      quantity = evaluator.quantity - 1

      quantity.times do
        checkout_item << build(:product_instance, discount_type: 'V')
      end
    end
  end

  factory :checkout_items_sr1, class: SuperMarket::Checkout::Item do
    initialize_with { new(build(:product_instance, :sr1)) }

    transient do
      quantity { 1 }
    end

    after(:build) do |checkout_item, evaluator|
      # @note: fix for the one item create on the first call
      quantity = evaluator.quantity - 1

      quantity.times do
        checkout_item << build(:product_instance, :sr1)
      end
    end
  end

  factory :checkout_items_cf1, class: SuperMarket::Checkout::Item do
    initialize_with { new(build(:product_instance, :cf1)) }

    transient do
      quantity { 1 }
    end

    after(:build) do |checkout_item, evaluator|
      # @note: fix for the one item create on the first call
      quantity = evaluator.quantity - 1

      quantity.times do
        checkout_item << build(:product_instance, :cf1)
      end
    end
  end

  factory :checkout_items_pr1, class: SuperMarket::Checkout::Item do
    initialize_with { new(build(:product_instance, :without_discount)) }

    transient do
      quantity { 1 }
    end

    after(:build) do |checkout_item, evaluator|
      # @note: fix for the one item create on the first call
      quantity = evaluator.quantity - 1

      quantity.times do
        checkout_item << build(:product_instance, :without_discount)
      end
    end
  end
end
