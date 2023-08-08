class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_burden
  belongs_to :shipping_area
  belongs_to :shipping_day

  has_one_attached :item_image

  validates :item_name,          presence: true
  validates :price,              presence: true,
                                 numericality: {
                                   only_integer: true,
                                   greater_than: 0,
                                   greater_than_or_equal_to: 300,
                                   less_than_or_equal_to: 9_999_999
                                 }
  validates :description,        presence: true
  validates :category_id,        presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id,       presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_burden_id, presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_area_id,   presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_day_id,    presence: { message: 'を選択してください' }, numericality: { other_than: 1, message: 'を選択してください' }
  validates :item_image,         presence: true
end