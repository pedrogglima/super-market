# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::PriceRules::BuyOneGetOneFree do
  subject(:price_rule) { SuperMarket::PriceRules::BuyOneGetOneFree }

  describe '#apply' do
    context 'when number of items is odd' do
      describe 'to return discount value' do
        let(:checkout_item) { build(:checkout_items_gr1, quantity: 1) }
        let(:discount) { 0 }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end

      describe 'to return discount value' do
        let(:checkout_item) { build(:checkout_items_gr1, quantity: 3) }
        let(:discount) { 1 * checkout_item.product_price }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end
    end

    context 'when number of items is even' do
      describe 'to return discount value' do
        let(:checkout_item) { build(:checkout_items_gr1, quantity: 2) }
        let(:discount) { 1 * checkout_item.product_price }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end

      describe 'to return discount value' do
        let(:checkout_item) { build(:checkout_items_gr1, quantity: 4) }
        let(:discount) { 2 * checkout_item.product_price }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end
    end
  end
end
