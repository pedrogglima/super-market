# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::PriceRules do
  subject(:price_rules) { SuperMarket::PriceRules.new }

  describe '#apply' do
    context 'when BuyOneGetOneFree discount' do
      let(:item) { build(:checkout_items_gr1, quantity: 2) }
      let(:discount) { 1 * item.product_price }

      it { expect(price_rules.apply(item)).to eq(discount) }
    end

    context 'when DiscountAfter discount' do
      let(:item) { build(:checkout_items_sr1, quantity: 3) }
      let(:discount) { 3 * item.product_discount }

      it { expect(price_rules.apply(item)).to eq(discount) }
    end

    context 'when item hasnt discount' do
      let(:item) { build(:checkout_items_pr1, quantity: 1) }
      let(:discount) { 0 }

      it { expect(price_rules.apply(item)).to eq(discount) }
    end
  end
end
