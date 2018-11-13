class Order < ActiveRecord::Base

  belongs_to :user
  has_many :line_items

  monetize :total_cents, numericality: true

  validates :stripe_charge_id, presence: true

  after_create :adjust_product_quantity

  def adjust_product_quantity
    self.line_items.each do |item|
      @product = item.product
      @product.update_columns(quantity: @product.quantity - item.quantity)
    end
  end

end
