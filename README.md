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
| password_confirmation | string  | null: false                 |
| last_name             | string  | null: false                 |
| first_name            | string  | null: false                 |
| last_name_kana        | string  | null: false                 |
| first_name_kana       | string  | null: false                 |

### アソシエーション:
# ユーザーは複数の商品を出品できるので、1対多の関係
has_many :items, dependent: :destroy

# ユーザーは複数の購入管理情報を持つことができるので、1対多の関係
has_many :purchases, dependent: :destroy



## 商品情報 (items):

| Column         | Type       | Options                          |
|----------------|------------|----------------------------------|
| user           | references | foreign key, null: false         |
| item_name      | string     | null: false                      |
| description    | text       | null: false                      |
| price          | integer    | null: false                      |
| condition_id   | integer    | null: false                      |
| category_id    | integer    | null: false                      |
| shipping_burden| string     | null: false                      |
| shipping_area  | string     | null: false                      |
| shipping_days  | string     | null: false                      |
| sales_fee      | integer    | null: false                      |
| sales_profit   | integer    | null: false                      |

### アソシエーション:
# 商品は1人のユーザーに所属するので、多対1の関係
belongs_to :user

# 商品は複数の購入管理情報を持つことができるので、1対多の関係
has_many :purchases, dependent: :destroy



## 購入管理テーブル (purchases):

| Column          | Type       | Options                     |
|---------------- |------------|-----------------------------|
| purchase_id     | integer    | primary key, null: false    |
| user            | references | foreign key, null: false    |
| item            | references | foreign key, null: false    |
| purchase_date   | datetime   | null: false                 |
| shipping_address| integer    | foreign key, null: false    |
| total_amount    | integer    | null: false                 |

### アソシエーション:
# 購入管理情報は1つのユーザーに所属するので、多対1の関係
belongs_to :user

# 購入管理情報は1つの商品に所属するので、多対1の関係
belongs_to :item

# 購入管理情報は1つの配送先に所属するので、多対1の関係
belongs_to :shipping_address




## 配送先テーブル (shipping_address):

| Column                 | Type    | Options                     |
|------------------------|---------|-----------------------------|
| shipping_address_id    | integer | primary key, null: false    |
| user_id                | integer | foreign key, null: false    |
| recipient_name         | string  | null: false                 |
| postal_code            | string  | null: false                 |
| address                | string  | null: false                 |
| shipping_fee_burden    | string  | null: false                 |
| shipping_area          | string  | null: false                 |
| shipping_days          | string  | null: false                 |

### アソシエーション:
# 配送先は複数の購入管理情報を持つことができるので、1対多の関係
has_many :purchases, dependent: :nullify

# 配送先は1人のユーザーに所属するので、多対1の関係
belongs_to :user
