class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :shipping_area_id, :city, :street_address, :building_name, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
  validates :postal_code, presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :shipping_area_id, presence: true, numericality: { other_than: 1 }
  validates :city
  validates :item_id
  validates :user_id
  validates :street_address
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
  validates :token
  end

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