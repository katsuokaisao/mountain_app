class Daily < ApplicationRecord
  has_many_attached :images
  # userメソッドでdaily_
  belongs_to :user
  belongs_to :mountain
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  # notificationsメソッドでNotificationモデルのdaily_idにこのモデルのidをセットしてくれる状態
  has_many :notifications, dependent: :destroy


  validates :comment, presence: true, length: {maximum: 600}
  validates :images, content_type: {in: %w[png jpg jpeg gif]}, size: {less_than: 5.megabytes}
  validates :mountain_name, presence: true, length: {maximum: 30}
  validates :title, presence: true, length: {maximum: 30}


    def like?(user)
      likes.where(user_id: user.id).exists?
    end
end
