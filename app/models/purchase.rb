class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  # 他の関連やバリデーションなどを定義する

  def self.create_with_forms(purchase_form, shipping_address_form)
    # フォームオブジェクトからデータを取得し、関連付けて保存する
    purchase = Purchase.new(user: purchase_form.user, item: purchase_form.item)
    shipping_address = ShippingAddress.new(
      postal_code: shipping_address_form.postal_code,
      prefecture_id: shipping_address_form.prefecture_id,
      city: shipping_address_form.city,
      street_address: shipping_address_form.street_address,
      building_name: shipping_address_form.building_name,
      phone_number: shipping_address_form.phone_number
    )

    if purchase.save && shipping_address.save
      purchase.update(shipping_address: shipping_address)
      return purchase
    else
      return nil
    end
  end
end
