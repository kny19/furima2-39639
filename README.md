# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# データベース設計

## ユーザー情報 (users):

| Column                | Type    | Options                     |
|-----------------------|---------|-----------------------------|
| username              | string  | null: false                 |
| email                 | string  | null: false, unique: true   |
| encrypted_password    | string  | null: false                 |
| last_name             | string  | null: false                 |
| first_name            | string  | null: false                 |
| last_name_kana        | string  | null: false                 |
| first_name_kana       | string  | null: false                 |
| birthday              | date    | null: false                 |


### アソシエーション:
# ユーザーは複数の商品を出品できるので、1対多の関係
has_many :items, dependent: :destroy

# ユーザーは複数の購入管理情報を持つことができるので、1対多の関係
has_many :purchases, dependent: :destroy



## 商品情報 (items):

| Column             | Type       | Options                          |
|--------------------|------------|----------------------------------|
| item_name          | string     | null: false                      |
| price              | integer    | null: false                      |
| description        | text       | null: false                      |
| category_id        | integer    | null: false                      |
| condition_id       | integer    | null: false                      |
| shipping_burden_id | integer    | null: false                      |
| shipping_area_id   | integer    | null: false                      |
| shipping_day_id    | integer    | null: false                      |
| user               | references | foreign key, null: false         |

### アソシエーション:
# 商品は1人のユーザーに所属するので、多対1の関係
belongs_to :user

# 商品は1つの購入管理情報に対して関連付けられるので、1対1の関係
has_one :purchase, dependent: :destroy



## 購入管理テーブル (purchases):

| Column          | Type        | Options                     |
|---------------- |-------------|-----------------------------|
| user            | references  | foreign key, null: false    |
| item            | references  | foreign key, null: false    |

### アソシエーション:
# 購入管理情報は1つのユーザーに所属するので、多対1の関係
belongs_to :user

# 購入管理情報は1つの商品に所属するので、多対1の関係
belongs_to :item

# 購入管理情報は1つの配送先に所属するので、多対1の関係
has_one :shipping_address




## 配送先テーブル (shipping_address):

| Column                 | Type         | Options                     |
|------------------------|--------------|-----------------------------|
| postal_code            | string       | null: false                 |
| prefecture_id          | integer      | primary key, null: false    |
| city                   | string       | null: false                 |
| street_address         | string       | null: false                 |
| building_name          | string       |                             |
| phone_number           | string       | null: false                 |
| purchase               | references   | foreign key, null: false    |

### アソシエーション:
belongs_to :purchase

