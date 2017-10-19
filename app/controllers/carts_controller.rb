class CartsController < ApplicationController
  # before_action :authenticate_user!

  def show
    if current_user
      cart_ids = $redis.lrange current_user_cart, -100, 100
      @cart_items = Item.find(cart_ids)
    elsif guest_user
      guest_cart_ids = $redis.lrange guest_user_cart, -100, 100
      @guest_cart_items = Item.find(guest_cart_ids)
    end
  end

  def add
    if current_user
      $redis.lpush current_user_cart, params[:item_id]
      render json: current_user.cart_count, status: 200
    elsif guest_user
      $redis.lpush guest_user_cart, params[:item_id]
      render json: guest_user.cart_count, status: 200
    end
  end

  def remove
    if current_user
      $redis.lrem current_user_cart, 1, params[:item_id]
      render json: current_user.cart_count, status: 200
    elsif guest_user
      $redis.lrem guest_user_cart, 1, params[:item_id]
      render json: guest_user.cart_count, status: 200
    end
  end


  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  def guest_user_cart
    "cart#{guest_user.id}"
  end


end
