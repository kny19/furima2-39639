class ChangeShippingAddressesColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :shipping_addresses, :prefecture_id, :shipping_area_id
    change_column :shipping_addresses, :shipping_area_id, :integer
  end
end