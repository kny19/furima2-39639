class PurchasesController < ApplicationController
  def index
    @purchase_form = PurchaseForm.new
    @shipping_address_form = ShippingAddressForm.new
    # 必要なインスタンス変数や処理を記述
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_form_params)
    @shipping_address_form = ShippingAddressForm.new(shipping_address_form_params)
    
    if @purchase_form.valid? && @shipping_address_form.valid?
      purchase = Purchase.create_with_forms(@purchase_form, @shipping_address_form)
      
      if purchase
        # 購入が成功した場合の処理
        redirect_to purchase_path(purchase) # 購入後のページに遷移
      else
        # 購入が失敗した場合の処理
        render :index
      end
    else
      render :index
    end
  end

  private

  def purchase_form_params
    # 購入フォームからのパラメータを取得
    params.require(:purchase_form).permit(:user_id, :item_id, ...)
  end

  def shipping_address_form_params
    # 配送先フォームからのパラメータを取得
    params.require(:shipping_address_form).permit(:postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number)
  end
end
