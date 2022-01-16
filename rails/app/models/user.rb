
require "validator/email_validator"

class User < ApplicationRecord
  # JWTトークンの発行と発行主の検索を行うモジュール
  include UserAuth::Tokenizable

  # dependent: :destroy ユーザー削除時に投稿も削除される
  has_many :microposts, dependent: :destroy
  # リレーションシップ
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                  foreign_key: "followed_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token

  # 検証前にemailを小文字に変換
  before_validation { self.email = self.email.downcase }



  # セキュアパスワード gem bcrypt
  # https://naokirin.hatenablog.com/entry/2019/03/29/032801
  has_secure_password


  ###
  # name属性 空を許可しない, 長さを制限, allow_black(空白の場合は長さチェックを行わないので二重にエラーが出なくて済む)
  validates :name,  presence: true, length: { maximum: 30, allow_blank: true }

  # password属性 空を許可しない, 8文字以上
  # nilを許容することでパスワード空でも編集できるようにする.
  # has_secure_passwordにより新規ユーザー登録時は存在性を検証する
  # 入力可能文字制限
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :password, presence: true,
                      length: { minimum: 8 },
                      format: {
                        with: VALID_PASSWORD_REGEX,
                        message: :invalid_password # エラーメッセージ
                      },
                      allow_nil: true

  # email
  validates :email, presence: true,
            email: { allow_blank: true } # カスタムバリデーション

  ###


  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # ユーザーのステータスフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # 同じemailでactivate済みユーザーがいたらtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end


  # クラスメソッド
  # Rubyのクラスメソッドとインスタンスメソッドの例
  # https://qiita.com/tbpgr/items/56eb65c0ea5882abbb07
  class << self

    # 渡された文字列のハッシュ値を返す
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def new_token
      SecureRandom.urlsafe_base64
    end

    # emailでactivate済みユーザーを探す, いないならnil
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end

  end

end
