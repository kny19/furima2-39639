FactoryBot.define do
  factory :purchase_shipping_address do
    postal_code { '123-4567' }
    shipping_area_id { 1 } # 任意のshipping_area_id
    city { '横浜市緑区' }
    street_address { '青山1-1-1' }
    building_name { '柳ビル103' }
    phone_number { '09012345678' }
    item_id { 1 } # 任意のitem_id
    user_id { 1 } # 任意のuser_id
    token { 1 } # 任意のトークン
  end
end
