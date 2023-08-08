class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :shipping_burden
  belongs_to :shipping_area
  belongs_to :shipping_day

  has_one_attached :item_image

  validates :item_name,          presence: true
  validates :price,              presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description,        presence: true
  validates :category_id,        presence: true
  validates :condition_id,       presence: true
  validates :shipping_burden_id, presence: true
  validates :shipping_area_id,   presence: true
  validates :shipping_day_id,    presence: true
  validates :item_image,         presence: true
end