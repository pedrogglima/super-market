# frozen_string_literal: true

FactoryBot.define do
  factory :price_rules, class: SuperMarket::PriceRules do
    initialize_with { new }
  end
end
