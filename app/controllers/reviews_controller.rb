class ReviewsController < ApplicationController
  before_action :set_product!

  def create
    @review = @product.reviews.build(review_params)
    @review.product_id = params[:product_id]
    @review.user_id = session[:user_id]
    if @review.save
      redirect_to "/"
    else
      redirect_to :back
    end
  end


  private
  def set_product!
    @product = Product.find(params[:product_id])
  end
  def review_params
    params.require(:review).permit(:description, :rating)
  end
end
