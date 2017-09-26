class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    @purchases = current_user.purchases
  end

  def show
  end


  private

  def purchase_params
    params.require(:purchase).permit(:user_id, :item_id => [])
  end

end
