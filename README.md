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

## ユーザー情報 (user):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| user_id     | integer | primary key, not null    |
| username    | string  | not null                 |
| email       | string  | not null                 |
| password    | string  | not null                 |
| address     | string  |                          |
| created_at  | datetime| not null                 |

## 商品情報 (item):

| Column        | Type    | Options                   |
|---------------|---------|--------------------------|
| item_id       | integer | primary key, not null    |
| seller_user_id| integer | foreign key, not null    |
| item_name     | string  | not null                 |
| description   | string  | not null                 |
| price         | integer | not null                 |
| condition     | string  |                          |
| category_id   | integer | foreign key              |
| image_id      | integer | foreign key              |
| created_at    | datetime| not null                 |

## 見た目の情報 (image):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| image_id    | integer | primary key, not null    |
| image_url   | string  |                          |

## 分類する情報 (category):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| category_id | integer | primary key, not null    |
| category_name|string  | not null                 |

## コメント情報 (comment):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| comment_id  | integer | primary key, not null    |
| item_id     | integer | foreign key, not null    |
| user_id     | integer | foreign key, not null    |
| content     | string  | not null                 |
| created_at  | datetime| not null                 |

## カード情報 (card):

| Column      | Type    | Options                   |
|-------------|---------|--------------------------|
| card_id     | integer | primary key, not null    |
| user_id     | integer | foreign key, not null    |
| card_number | string  | not null                 |
| expiration_date | string| not null                 |
| cvv         | string  | not null                 |

## 購入者情報 (purchase):

| Column         | Type    | Options                   |
|----------------|---------|--------------------------|
| purchase_id    | integer | primary key, not null    |
| item_id        | integer | foreign key, not null    |
| buyer_user_id  | integer | foreign key, not null    |
| purchase_date  | datetime| not null                 |
| shipping_address|string  |                          |
| total_amount   | integer |                          |