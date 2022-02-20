# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::PriceRules::DiscountAfter do
  subject(:price_rule) { SuperMarket::PriceRules::DiscountAfter }

  describe '#apply' do
    context 'when discount type is percentual' do
      context 'and quantity less than promotion' do
        describe 'to return discount value' do
          let(:checkout_item) { build(:checkout_items_sr1, quantity: 1) }
          let(:discount) { 0 }

          it { expect(price_rule.apply(checkout_item)).to eq(discount) }
        end
      end

      describe 'to return discount value' do
        let(:quantity) { 3 }
        let(:checkout_item) { build(:checkout_items_sr1, quantity: quantity) }
        let(:discount) { quantity * checkout_item.product_discount }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end

      describe 'to return discount value' do
        let(:quantity) { 4 }
        let(:checkout_item) { build(:checkout_items_sr1, quantity: quantity) }
        let(:discount) { quantity * checkout_item.product_discount }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end
    end

    context 'when discount type is value' do
      context 'and quantity less than promotion' do
        describe 'to return discount value' do
          let(:checkout_item) { build(:checkout_items_sr1, quantity: 1) }
          let(:discount) { 0 }

          it { expect(price_rule.apply(checkout_item)).to eq(discount) }
        end
      end

      describe 'to return discount value' do
        let(:quantity) { 3 }
        let(:checkout_item) { build(:checkout_items_sr1, quantity: quantity) }
        let(:discount_value) { checkout_item.product_discount }
        let(:discount) { (quantity * discount_value) }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end

      describe 'to return discount value' do
        let(:quantity) { 4 }
        let(:checkout_item) { build(:checkout_items_sr1, quantity: quantity) }
        let(:discount_value) { checkout_item.product_discount }
        let(:discount) { quantity * discount_value }

        it { expect(price_rule.apply(checkout_item)).to eq(discount) }
      end
    end
  end
end
