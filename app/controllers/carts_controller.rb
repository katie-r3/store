class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart_ids = $redis.lrange current_user_cart, -100, 100
    @cart_items = Item.find(cart_ids)
  end

  def add
    $redis.lpush current_user_cart, params[:item_id]
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.lrem current_user_cart, - 1, params[:item_id]
    render json: current_user.cart_count, status: 200
  end


  private

  def current_user_cart
    "cart#{current_user.id}"
  end


end
