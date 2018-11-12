require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.new(name: "new_category")
      @category.save
      @product1 = @category.products.create!(name: "product_1", price_cents: 4000, quantity: 50)
      @product2 = @category.products.create!(name: "product_2", price_cents: 10000, quantity: 20)
      # Setup at least one product that will NOT be in the order
      @product3 = @category.products.create!(name: "product_3", price_cents: 5000, quantity: 30)
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: "my_email@email.com",
        total_cents: 4000,
        stripe_charge_id: 1
      )
      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eq 49
      expect(@product2.quantity).to eq 19
    end
    # pending test 2
    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
       @order = Order.new(
        email: "my_email@email.com",
        total_cents: 4000,
        stripe_charge_id: 1
      )

      # 2. build line items on @order
      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      @order.line_items.new(
        product: @product2,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price * 1
      )
      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to eq 30
    end
  end
end
