class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, presence: true
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/, message: "は英字と数字の両方を含む必要があります" }
  validates :last_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: "は全角（漢字・ひらがな・カタカナ）での入力が必須です" }
  validates :last_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角（カタカナ）での入力が必須です" }

  has_many :items
  has_many :purchases
end