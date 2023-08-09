FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    description { Faker::Lorem.paragraph }
    category_id { 1 } # 仮のカテゴリーIDを指定する例
    condition_id { 1 } # 仮の状態IDを指定する例
    shipping_burden_id { 1 } # 仮の配送料負担IDを指定する例
    shipping_area_id { 1 } # 仮の発送元地域IDを指定する例
    shipping_day_id { 1 } # 仮の発送までの日数IDを指定する例
    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end