class OrdersController < ApplicationController

  after_create :adjust_product_quantity

  def show
    @order = Order.find(params[:id])
    @email = @order.email
    @total = @order.total_cents.to_f / 100
    @purchase = enhanced_cart
    UserMailer.receipt(@order, @purchase).deliver_now
    empty_cart!
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      redirect_to order, notice: 'Your Order has been placed.'
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

  def adjust_product_quantity
    @items = LineItems.find_by order_id(self.id)
    @items.each do |item|
      @product = Product.find_by id(item.product_id)
      @product.update_columns(quantity: @product.quantity - 1)
    end
  end
end
