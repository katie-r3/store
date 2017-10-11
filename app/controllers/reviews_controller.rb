class ReviewsController < ApplicationController
  before_action :find_item
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :signed_in?

  def signed_in?
    if current_user.nil?
      flash[:notice] = "Access denied! You must be signed in!"
      redirect_to items_path
    end
  end

  def index
  end

  def new
    if current_user
      @review = Review.where(user_id: current_user.id, item_id: params[:item_id]).first_or_initialize
      if @review.id.present?
        render 'edit'
      end
    end
  end

  def create
    @review = Review.new(review_params)
    @review.item_id = @item.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to item_reviews_path(@item)
      flash[:notice] = "Review created!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to item_path(@item)
      flash[:notice] = "Successfully updated review!"
    else
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to item_path(@item)
    flash[:notice] = "Review deleted."
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end


end
