class ReviewsController < ApplicationController
  before_filter :logged_in?

  def create
    @product = Product.find(params[:product_id])
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
  def review_params
    params.require(:review).permit(:description, :rating)
  end
  def logged_in?
    if (session[:user_id])
      return true
    end
    return false
  end
end
