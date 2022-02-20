# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::Checkout do
  let(:product_gr1) { build(:product_instance, :gr1) }
  let(:product_sr1) { build(:product_instance, :sr1) }
  let(:product_cf1) { build(:product_instance, :cf1) }

  let(:price_rules) { build(:price_rules) }
  subject(:checkout) { SuperMarket::Checkout.new(price_rules) }

  describe 'initialize with' do
    context 'should respond_to' do
      it { expect(checkout.pricing_rules).to eq(price_rules) }
      it { expect(checkout.items).to eq([]) }
    end
  end

  describe '#scan' do
    context 'when product is in stock' do
      context 'when product is not in the checkout' do
        it { expect(checkout.scan(product_gr1.code).to_h).to eq(product_gr1.to_h) }
      end

      context 'when product is already in the checkout' do
        before { checkout.scan(product_gr1.code) }

        it { expect(checkout.scan(product_gr1.code).to_h).to eq(product_gr1.to_h) }
      end
    end

    context 'when product is not in stock' do
      let(:product) { build(:product_instance, :out_stock) }

      it { expect(checkout.scan(product.code)).to be_nil }
    end
  end

  describe '#total_items' do
    context 'when checkout has items' do
      before { checkout.scan(product_gr1.code) }
      it { expect(checkout.total_items).to eq(1) }
    end

    context 'when checkout has no items' do
      it { expect(checkout.total_items).to eq(0) }
    end
  end

  describe '#total_amount' do
    context 'when checkout has items' do
      before do
        # 3.11 (buy 2 get 1 free)
        # discount 3.11
        # normal price 6.22
        checkout.scan(product_gr1.code)
        checkout.scan(product_gr1.code)

        # 3 * 0.5 = 1.5 (buy 3 get 0.50 off per item)
        # discount 1.5
        # normal price = 3 * 5 = 15
        checkout.scan(product_sr1.code)
        checkout.scan(product_sr1.code)
        checkout.scan(product_sr1.code)

        # 3 * 3.743 = 11.23 (buy 3 get 3.74 off per item)
        # discount 11.23
        # normal price = 3 * 11.23 = 33.69
        checkout.scan(product_cf1.code)
        checkout.scan(product_cf1.code)
        checkout.scan(product_cf1.code)
      end

      let(:normal_price) { 54.91 }
      let(:discount) { 15.84 }
      let(:total_amount) { (normal_price - discount).round(2) }
      it { expect(checkout.total_amount).to eq(total_amount) }
    end

    context 'when checkout has no items' do
      it { expect(checkout.total_amount).to eq(0) }
    end
  end

  describe '#total_discount_amount' do
    before do
      # 3.11 (buy 2 get 1 free)
      checkout.scan(product_gr1.code)
      checkout.scan(product_gr1.code)

      # 3 * 0.5 (buy 3 get 0.50 off per item)
      checkout.scan(product_sr1.code)
      checkout.scan(product_sr1.code)
      checkout.scan(product_sr1.code)

      # 3 * 3.743 (buy 3 get 3.74 off per item)
      checkout.scan(product_cf1.code)
      checkout.scan(product_cf1.code)
      checkout.scan(product_cf1.code)

      # 3.11 + 1.5 + 11,23 = 15,84
    end
    let(:total_discount_amount) { 15.84 }

    it { expect(checkout.total_discount_amount).to eq(total_discount_amount) }
  end

  describe '#total_before_discount_amount' do
    before do
      # 3.11 + 3.11 = 6.22
      checkout.scan(product_gr1.code)
      checkout.scan(product_gr1.code)

      # 5.00 + 5.00 + 5.00 = 15.00
      checkout.scan(product_sr1.code)
      checkout.scan(product_sr1.code)
      checkout.scan(product_sr1.code)

      # 11.23 + 11.23 + 11.23 = 33.69
      checkout.scan(product_cf1.code)
      checkout.scan(product_cf1.code)
      checkout.scan(product_cf1.code)

      # 6.22 + 15.00 + 33.69 = 54,91
    end

    let(:total_before_discount_amount) { 54.91 }

    it { expect(checkout.total_before_discount_amount).to eq(total_before_discount_amount) }
  end
end
