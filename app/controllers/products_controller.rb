class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
    @reviews = Review.where(product_id: params[:id]).order(created_at: :desc)
    @rating = average_rating(@reviews)
  end

  private
  def average_rating(reviews)
    reviews.ratings.average(:ratings)
  end
end
