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

    create_amount = @amount.to_f / 100

    customer = StripeTool.create_customer(email: params[:stripeEmail], stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, amount: @amount, description: 'Rails Stripe Customer')

    @purchase = Purchase.create(user_id: current_user.id, amount: create_amount, items: current_user.get_cart_items, ordered: true)

    UserMailer.order_email(current_user).deliver_now

    if !current_user.no_more?
      InventoryMailer.inventory_email(@item).deliver_now
    end

    current_user.purchase_cart_items!

    redirect_to thanks_path


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

  end


  def thanks
  end


end
