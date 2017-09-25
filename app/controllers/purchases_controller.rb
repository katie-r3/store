class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchases = current_user.purchases
  end

  def show
  end

  def new
    @purchase = Purchase.new(purchase_params)
  end

  def create
    purchase = current_user.purchases.build(purchase_params)
    if purchase.save
      render json: purchase, status: 201
    else
      render json: { errors: purchase.errors }, status: 422
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :item_id => [])
  end

end
