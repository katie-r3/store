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

    create_amount = current_user.cart_total_price.to_f

    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, amount: @amount, description: 'Rails Strip Customer')

    purchase = Purchase.create(user_id: customer.id, amount: create_amount, item_id: 1)

    redirect_to purchase_url

    current_user.purchase_cart_items!

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end


  def thanks
  end


end
