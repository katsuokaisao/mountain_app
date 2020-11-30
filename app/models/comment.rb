class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :daily
  # notificationsメソッドでnotificationモデルのcomment_idにこのモデルのidをセットしてくれる状態=>直す必要なし
  has_many :notifications, dependent: :destroy

  validates :content, presence: true
end
