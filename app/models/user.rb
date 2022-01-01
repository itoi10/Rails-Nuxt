class User < ApplicationRecord
  # emailを小文字に変換
  before_save { self.email = self.email.downcase }

  # name属性 空を許可しない, 長さを制限
  validates :name,  presence: true, length: { maximum: 50 }

  # email属性 空を許可しない, 長さを制限, フォーマット検証, 一意
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # セキュアパスワード
  has_secure_password
  # password属性 空を許可しない, 6文字以上
  validates :password, presence: true, length: { minimum: 6 }


  # クラスメソッド

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
