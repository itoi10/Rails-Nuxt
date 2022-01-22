class Micropost < ApplicationRecord
  belongs_to :user
  # 画像
  has_one_attached :image

  # 作成日降順
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  # 画像バリデーション
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                                      message: '対応形式はJPG,GIF,PNGです' },
                      size: { less_than: 5.megabytes, message: 'サイズは5MBまでです' }
end
