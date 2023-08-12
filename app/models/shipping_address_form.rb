class ShippingAddressForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building_name, :phone_number

  validates :postal_code, :prefecture_id, :city, :street_address, :phone_number, presence: true
  # 他のバリデーションも追加

  def save
    if valid?
      shipping_address = ShippingAddress.create(
        postal_code:    postal_code,
        prefecture_id:  prefecture_id,
        city:           city,
        street_address: street_address,
        building_name:  building_name,
        phone_number:   phone_number
      )
      # 他の保存処理も追加
      return true
    else
      return false
    end
  end
end





