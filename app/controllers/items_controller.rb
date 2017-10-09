class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :is_admin?, only: [:edit, :update, :destroy]


  def is_admin?
    if current_user.nil? || current_user.admin? == false
      flash[:notice] = "Access denied! You aren't allowed to do that!"
      redirect_to items_path
    end
  end


  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    if params[:search]
      @items = Item.search(params[:search]).order("created_at DESC")
    else
      @items = Item.all.order("created_at DESC")
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @cart_action = @item.cart_action current_user.try :id
    if @item.reviews.blank?
      @average_review = 0
    else
      @average_review = @item.reviews.average(:rating).round(2)
    end
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  private

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :price, :description, :avatar, :quantity)
    end


end
