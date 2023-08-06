class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @items = Item.new
  end

  def create
    @item = item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end
end
