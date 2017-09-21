class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    old_amt = current_user.cart_total_price.to_f * 100
    @amount = old_amt.to_i

    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, amount: @amount, description: 'Rails Strip Customer')

    current_user.purchase_cart_items!
    redirect_to thanks_path


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end


end
