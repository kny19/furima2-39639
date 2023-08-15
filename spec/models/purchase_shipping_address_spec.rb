require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do
  describe '購入情報の保存' do
    before do
      @user = FactoryBot.create(:user)  # 正しいファクトリ名を使用してユーザーを生成
      @item = FactoryBot.create(:item)  # 正しいファクトリ名を使用してアイテムを生成
      @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_shipping_address).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_shipping_address.building_name = nil
        expect(@purchase_shipping_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_shipping_address.postal_code = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_shipping_address.postal_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end

      it 'shipping_area_idを選択していないと保存できないこと' do
        @purchase_shipping_address.shipping_area_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'cityが空だと保存できないこと' do
        @purchase_shipping_address.city = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空だと保存できないこと' do
        @purchase_shipping_address.street_address = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_shipping_address.phone_number = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが半角数字以外の文字を含むと保存できないこと' do
        @purchase_shipping_address.phone_number = '090-1234-5678'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'shipping_area_idが「---」の場合は保存できないこと' do
        @purchase_shipping_address.shipping_area_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'phone_numberが9桁以下では保存できないこと' do
        @purchase_shipping_address.phone_number = '123456789'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが12桁以上では保存できないこと' do
        @purchase_shipping_address.phone_number = '123456789012'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'tokenが空では保存できないこと' do
        @purchase_shipping_address.token = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていなければ保存できないこと' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていなければ保存できないこと' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end