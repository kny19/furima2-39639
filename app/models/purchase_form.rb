class PurchaseForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :other_attributes...

  validates :user_id, :item_id, presence: true
  # 他のバリデーションも追加

  def save
    if valid?
      purchase = Purchase.create(user_id: user_id, item_id: item_id)
      # 他の保存処理も追加
      return true
    else
      return false
    end
  end
end