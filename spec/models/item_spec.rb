require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = build(:item)
  end

  describe "validations" do
    context '正常系' do
      it '有効な属性値の場合、有効であること' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it '商品名がない場合、無効であること' do
        @item.item_name = nil
        expect(@item).not_to be_valid
      end

      it '価格がない場合、無効であること' do
        @item.price = nil
        expect(@item).not_to be_valid
      end

      it '価格が整数でない場合、無効であること' do
        @item.price = "abc"
        expect(@item).not_to be_valid
      end

      it '価格が0以下の場合、無効であること' do
        @item.price = 0
        expect(@item).not_to be_valid
      end

      it '説明がない場合、無効であること' do
        @item.description = nil
        expect(@item).not_to be_valid
      end

      it 'カテゴリーがない場合、無効であること' do
        @item.category = nil
        expect(@item).not_to be_valid
      end

      it '商品の状態がない場合、無効であること' do
        @item.condition = nil
        expect(@item).not_to be_valid
      end

      it '配送料の負担がない場合、無効であること' do
        @item.shipping_burden = nil
        expect(@item).not_to be_valid
      end

      it '発送元の地域がない場合、無効であること' do
        @item.shipping_area = nil
        expect(@item).not_to be_valid
      end

      it '発送までの日数がない場合、無効であること' do
        @item.shipping_day = nil
        expect(@item).not_to be_valid
      end

      it '商品画像がない場合、無効であること' do
        @item.item_image = nil
        expect(@item).not_to be_valid
      end
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should belong_to(:shipping_burden) }
    it { should belong_to(:shipping_area) }
    it { should belong_to(:shipping_day) }
    it { should have_one_attached(:item_image) }
  end
end
