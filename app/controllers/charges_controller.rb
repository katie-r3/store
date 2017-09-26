class ChargesController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    if current_user.state == 'CA'
      old_amt = current_user.add_sales_tax.to_f * 100
      @amount = old_amt.to_i
    else
      old_amt = current_user.cart_total_price.to_f * 100
      @amount = old_amt.to_i
    end


    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, amount: @amount, description: 'Rails Strip Customer')

    current_user.purchase_cart_items!
    current_user.create_purchase

    redirect_to thanks_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end


end
