class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchases = current_user.purchases
  end

  def show
  end

  def new
    @purchase = Purchase.new
    @purchase.items.build

    respond_to do |format|
      format.html { redirect_to @purchase }
      format.json { render :index, status: :created }
    end
  end


  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :item_id => [])
  end

end
