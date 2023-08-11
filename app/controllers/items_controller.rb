class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]  # ログイン状態のユーザーのみ new と create にアクセスできる

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path notice: 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :price, :description, :category_id, :condition_id, :shipping_burden_id, :shipping_area_id, :shipping_day_id, :item_image).merge(user_id: current_user.id)
  end
end
