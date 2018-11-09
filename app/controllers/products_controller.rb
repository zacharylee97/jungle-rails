class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Review.where(product_id: params[:id]).order(created_at: :desc)
    @rating = average_rating(@reviews).round(2)
  end

  private
  def average_rating(reviews)
    sum = 0.0
    @reviews.each do |review|
      sum += review.rating
    end
    return sum / reviews.count
  end
end
