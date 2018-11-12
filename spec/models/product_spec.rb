require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @category = Category.new(name: "new_category")
      @product = @category.products.new(name: "new_product", price: 100.00, quantity: 10)
      expect(@product.save).to eq true
    end
    it "should have an error if product does not include name" do
      @category = Category.new(name: "new_category")
      @product = @category.products.new(name: nil, price: 100.00, quantity: 10)
      @product.valid?
      expect(@product.errors.full_messages).to eq ["Name can't be blank"]
    end
    it "should have an error if product does not include price" do
      @category = Category.new(name: "new_category")
      @product = @category.products.new(name: "new_product", price: nil, quantity: 10)
      @product.valid?
      expect(@product.errors.full_messages).to eq ["Price cents is not a number", "Price is not a number", "Price can't be blank"]
    end
    it "should have an error if product does not include quantity" do
      @category = Category.new(name: "new_category")
      @product = @category.products.new(name: "new_product", price: 100.00, quantity: nil)
      @product.valid?
      expect(@product.errors.full_messages).to eq ["Quantity can't be blank"]
    end
    it "should have an error if product does not include category" do
      @product = Product.new(name: "new_product", price: 100.00, quantity: 10)
      @product.valid?
      expect(@product.errors.full_messages).to eq ["Category can't be blank"]
    end
  end
end
