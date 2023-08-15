class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @purchase_form = PurchaseShippingAddress.new
    @item = Item.find(params[:item_id])
    return redirect_to root_path if current_user == @item.user||@item.purchase != nil
  end

  def new
    @item = Item.find(params[:item_id])
    @purchase_form = PurchaseShippingAddress.new
  end

  def create
    @purchase_form = PurchaseShippingAddress.new(purchase_shipping_address_params)
    @purchase_form.user_id = current_user.id
    @item = Item.find(params[:item_id]) # Add this line to ensure @item is defined
    if @purchase_form.valid?
      Payjp.api_key = "sk_test_bc1473de0c2e1cec92a025e0"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_shipping_address_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
       @purchase_form.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      @item = Item.find(params[:item_id]) # Add this line to ensure @item is defined
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @purchase = Purchase.find(params[:id])
  end

  private

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