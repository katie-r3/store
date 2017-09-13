class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    cart_ids = $redis.smembers current_user_cart
    @cart_items = Item.find(cart_ids)
  end

  def add
    $redis.sadd current_user_cart, params[:item_id]
    render json: current_user.cart_count, status: 200
  end

  def remove
    $redis.srem current_user_cart, params[:item_id]
    render json: current_user.cart_count, status: 200
  end


  private

  def current_user_cart
    "cart#{current_user.id}"
  end
end
