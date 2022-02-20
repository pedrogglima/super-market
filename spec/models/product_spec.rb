# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::Product do
  let!(:valid_attrs) { attributes_for(:product) }
  subject(:product) { SuperMarket::Product.new(valid_attrs) }

  describe 'initialize with' do
    context 'should respond_to' do
      it { expect(product.id).to eq(valid_attrs[:id]) }
      it { expect(product.code).to eq(valid_attrs[:code]) }
      it { expect(product.name).to eq(valid_attrs[:name]) }
      it { expect(product.price).to eq(BigDecimal(valid_attrs[:price].to_s)) }
      it { expect(product.quantity).to eq(valid_attrs[:quantity]) }
      it { expect(product.discount_value).to eq(valid_attrs[:discount_value]) }
      it { expect(product.discount_type).to eq(valid_attrs[:discount_type]) }
    end
  end

  describe '#in_stock?' do
    context 'when product is in stock' do
      context 'without argument' do
        it { expect(product.in_stock?).to be_truthy }
      end

      it { expect(product.in_stock?(1)).to be_truthy }
    end

    context 'when product is not in stock' do
      it { expect(product.in_stock?(10)).to be_falsey }
    end
  end

  describe '#percentual_discount?' do
    context 'when discount is percentual' do
      let(:valid_attrs) { attributes_for(:product, :percentual_discount) }

      it { expect(product.percentual_discount?).to be_truthy }
    end

    context 'when discount is not percentual' do
      it { expect(product.percentual_discount?).to be_falsey }
    end
  end

  describe '#discount' do
    it { expect(product.discount).to be_an_instance_of(BigDecimal) }

    context 'when without argument' do
      let(:valid_attrs) { attributes_for(:product, discount_value: 0.5) }
      let(:quantity) { 1 }
      let(:discount) { quantity * BigDecimal('0.5') }

      it { expect(product.discount).to eq(BigDecimal(discount)) }
    end

    context 'when with argument' do
      let(:valid_attrs) { attributes_for(:product, price: 3.11, discount_value: 0.5) }
      let(:quantity) { 2 }
      let(:discount) { quantity * BigDecimal('0.5') }

      it { expect(product.discount(quantity)).to eq(discount) }
    end

    context 'when percentual discount' do
      let(:valid_attrs) { attributes_for(:product, price: 11.23, discount_value: 33.33, discount_type: 'P') }
      let(:quantity) { 3 }
      let(:percentage) { BigDecimal('33.33') / BigDecimal('100') }
      let(:discount) { (quantity * (BigDecimal('11.23') * percentage)).round(2) }

      it { expect(product.discount(quantity).to_f).to eq(discount.to_f) }
    end
  end

  describe '#multiply_price' do
    it { expect(product.multiply_price).to be_an_instance_of(BigDecimal) }

    context 'when without argument' do
      let(:valid_attrs) { attributes_for(:product, price: 0.75) }
      let(:quantity) { 1 }
      let(:discount) { quantity * BigDecimal('0.75') }

      it { expect(product.multiply_price).to eq(BigDecimal(discount)) }
    end

    context 'when with argument' do
      let(:valid_attrs) { attributes_for(:product, price: 0.75) }
      let(:quantity) { 2 }
      let(:discount) { quantity * BigDecimal('0.75') }

      it { expect(product.multiply_price(quantity)).to eq(discount) }
    end
  end
end
