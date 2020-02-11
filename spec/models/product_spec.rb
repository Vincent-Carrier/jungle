require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    mock_category = Category.new(name: "Utensils")
    mock_product = Product.new(name: "Spork", price_cents: 100000, quantity: 42, category: mock_category)

    
    it 'should be valid' do
      expect(mock_product).to be_valid
      mock_product.save
      expect(mock_product.errors.full_messages).to eql([])
    end

    it 'should have a name' do
      mock_product.name = nil
      mock_product.save
      expect(mock_product.errors.full_messages).to eql(["Name can't be blank"])
    end

    it 'should have a price' do
      mock_product.price_cents = nil
      mock_product.save
      expect(mock_product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'should have a quantity' do
      mock_product.quantity = nil
      mock_product.save
      expect(mock_product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should have a category' do
      mock_product.category = nil
      mock_product.save
      expect(mock_product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
