class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_purchase, only: [:show, :edit, :update, :destroy]


  def index
    @purchases = current_user.purchases.all.order("created_at DESC")
  end

  def show
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.user_id = current_user.id
    if @purchase.save
      redirect_to purchase_path(@purchase)
    end
  end



  private

  def purchase_params
    params.require(:purchase).permit(:amount, :user_id)
  end

  def find_purchase
    @purchase = Purchase.find(params[:id])
  end

end
