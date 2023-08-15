class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_area_id, :city, :street_address, :building_name, :phone_number, :item_id, :user_id, :token

  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :shipping_area_id, presence: true
  validates :city, presence: true
  validates :street_address, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  validates :token, presence: true

  def save

    purchase = Purchase.create(item_id: item_id, user_id: user_id)

    shipping_address = ShippingAddress.create(
      postal_code:      postal_code,
      shipping_area_id: shipping_area_id,
      city:             city,
      street_address:   street_address,
      building_name:    building_name,
      phone_number:     phone_number,
      purchase_id:      purchase.id
    )
  end
end