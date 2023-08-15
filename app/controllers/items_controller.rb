class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "商品が作成されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    redirect_to root_path if current_user != @item.user||@item.purchase != nil
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "商品情報が更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.user == current_user
      @item.destroy
      redirect_to root_path, notice: "商品が削除されました。"
    else
      redirect_to root_path, alert: "他のユーザーの商品は削除できません。"
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:item_name, :price, :description, :category_id, :condition_id, :shipping_burden_id, :shipping_area_id, :shipping_day_id, :item_image).merge(user_id: current_user.id)
  end
end
