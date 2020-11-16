class Daily < ApplicationRecord
  belongs_to :user
  belongs_to :mountain
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many_attached :images
  validates :mountain_name, presence: true, length: {maximum: 30}
  validates :title, presence: true, length: {maximum: 30}
  validates :comment, presence: true, length: {maximum: 600}
  validates :images, content_type: {in: %[png jpg jpeg gif]},
                    size: {less_than: 5.megabytes}
  def like?(user)
    likes.where(user_id: user.id).exists?
  end
  
end
