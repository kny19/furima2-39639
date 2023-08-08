FactoryBot.define do
  factory :item do
    item_name { "テスト商品" }
    price { 1000 }
    description { "これはテスト商品の説明です。" }
    category { Category.first || association(:category) }
    condition { Condition.first || association(:condition) }
    shipping_burden { ShippingBurden.first || association(:shipping_burden) }
    shipping_area { ShippingArea.first || association(:shipping_area) }
    shipping_day { ShippingDay.first || association(:shipping_day) }
    item_image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'item_image.jpg'), 'image/jpeg') }
    user

    trait :with_sold_out do
      sold_out { true }
    end
  end
end
