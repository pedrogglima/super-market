# frozen_string_literal: true

require 'ruby_helper'

class DummyClass
  extend SuperMarket::ProductQueryable

  # This represents a relationship between DummyClass and Product
  # It's used to check if a product has pricing rules
  def self.products
    @products ||= find_ids([2, 3])
  end
end

RSpec.describe DummyClass do
  let(:products) { build(:products_from_csv) }
  subject(:klass) { DummyClass }

  # @note: improvement by creating csv for test & production, otherwise changes
  # on the csv will break the tests
  #
  describe '#all' do
    it 'should match with csv file' do
      klass.all.each_with_index do |product, i|
        expect(product.to_h).to eq(products[i].to_h)
      end
    end
  end

  describe '#find' do
    context 'when product exists' do
      it 'should return product' do
        expect(klass.find(1).to_h).to eq(products[0].to_h)
      end
    end

    context 'when product does not exist' do
      it 'should return nil' do
        expect(klass.find(10)).to be_nil
      end
    end
  end

  describe '#find_by' do
    context 'when product exists' do
      it 'should return product' do
        expect(klass.find_by(:code, 'GR1').to_h).to eq(products[0].to_h)
      end
    end

    context 'when product does not exist' do
      it 'should return nil' do
        expect(klass.find_by(:code, 'INEXISTENT')).to be_nil
      end
    end
  end

  describe '#find_ids' do
    it 'should return products' do
      expect(klass.find_ids([1, 2]).length).to eq(2)
    end
  end

  describe '#product_with_discount?' do
    context 'when product has discount' do
      it 'should return true' do
        product = instance_double('Product', product_id: 1)

        expect(klass.product_with_discount?(product)).to be_truthy
      end
    end

    context 'when product does not have discount' do
      it 'should return false' do
        product = instance_double('Product', product_id: -1)

        expect(klass.product_with_discount?(product)).to be_falsey
      end
    end
  end
end
