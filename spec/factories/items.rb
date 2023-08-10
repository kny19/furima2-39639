FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    description { Faker::Lorem.paragraph }
    category_id { 2 } # 仮のカテゴリーIDを指定（1以外の有効なID）
    condition_id { 2 } # 仮の状態IDを指定（1以外の有効なID）
    shipping_burden_id { 2 } # 仮の配送料負担IDを指定（1以外の有効なID）
    shipping_area_id { 2 } # 仮の発送元地域IDを指定（1以外の有効なID）
    shipping_day_id { 2 } # 仮の発送までの日数IDを指定（1以外の有効なID）
    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png', content_type: 'image/png')
    end
  end
end
