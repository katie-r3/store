class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    old_amt = current_user.cart_total_price.to_f * 100
    @amount = old_amt.to_i

    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])


    charge = StripeTool.create_charge(customer_id: customer.id, amount: @amount, description: 'Rails Strip Customer')

    redirect_to thanks_path
    $redis.srem current_user_cart, params[:item_id]


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private

  def current_user_cart
    "cart#{current_user.id}"
  end

end
