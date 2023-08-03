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

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| user_id     | integer | primary key, null: false    |
| username    | string  | null: false                 |
| email       | string  | null: false                 |
| password    | string  | null: false                 |
| address     | string  |                             |
| created_at  | datetime| null: false                 |

## 商品情報 (items):

| Column        | Type    | Options                   |
|---------------|---------|--------------------------|
| item_id       | integer | primary key, null: false    |
| user　　　　　　| integer | foreign key, null: false    |
| item_name     | string  | null: false                 |
| description   | string  | null: false                 |
| price         | integer | null: false                 |
| condition     | string  |                             |
| category_id   | integer | null: false                 |
| image_id      | integer | foreign key                 |


## 分類する情報 (categorys):

| Column      | Type    | Options                     |
|-------------|---------|--------------------------|
| category_id | integer | primary key, null: false    |
| category_name|string  | null: false                 |

## コメント情報 (comments):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| comment_id  | integer | primary key, null: false    |
| item_id     | integer | foreign key, null: false    |
| user_id     | integer | foreign key, null: false    |
| content     | string  | null: false                 |
| created_at  | datetime| null: false                 |


## 購入者情報 (purchases):

| Column          | Type    | Options                   |
|---------------- |---------|--------------------------|
| purchase_id     | integer | primary key, null: false    |
| item_id         | integer | foreign key, null: false    |
| buyer_user_id   | integer | foreign key, null: false    |
| purchase_date   | datetime| null: false                 |
| shipping_address| integer | foreign key, null: false    |
| total_amount    | integer | null: false                 |


## 配送先テーブル (shipping_address):

| Column         | Type    | Options                   |
|----------------|---------|--------------------------|
| shipping_address_id    | integer | primary key, null: false    |
| user_id                | integer | foreign key, null: false    |
| recipient_name         | string  | null: false                 |
| postal_code            | string  | null: false                 |
| address                | string  | null: false                 |
| created_at             | datetime| null: false                 |