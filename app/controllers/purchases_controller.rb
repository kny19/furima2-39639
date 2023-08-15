class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseShippingAddress.new
    return redirect_to root_path if @item_already_purchased
  end

  def create
    @purchase_form = PurchaseShippingAddress.new(purchase_shipping_address_params)
    @purchase_form.user_id = current_user.id
    if @purchase_form.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_shipping_address_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
       @purchase_form.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    @item_already_purchased = current_user == @item.user || @item.purchase.present?
  end

  def purchase_shipping_address_params
    params.require(:purchase_shipping_address).permit(
      :postal_code,
      :shipping_area_id,
      :city,
      :street_address,
      :building_name,
      :phone_number,
    ).merge(item_id: params[:item_id], token: params[:token], user_id: current_user.id)
  end
end