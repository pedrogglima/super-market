# frozen_string_literal: true

require 'ruby_helper'

RSpec.describe SuperMarket::Checkout::Item do
  let(:product) { build(:product_instance) }
  subject(:item) { SuperMarket::Checkout::Item.new(product) }

  describe 'initialize with' do
    context 'should respond_to' do
      it { expect(item.product_id).to eq(product.id) }
      it { expect(item.product_code).to eq(product.code) }
      it { expect(item.products.first).to eq(product) }
    end
  end

  describe '#quantity' do
    it { expect(item.quantity).to eq(1) }
  end

  describe '#product_price' do
    it { expect(item.product_price).to eq(product.price) }
  end

  describe '#product_discount' do
    it { expect(item.product_discount).to eq(product.discount_value) }
  end

  pending '#total_price'

  describe '#<<' do
    it { expect { item << product }.to change(item, :products).to([product, product]) }
  end
end
