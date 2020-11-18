class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar,  dependent: :destroy
  validates :avatar, content_type: {in: %w[png jpg jpeg gif], message: '拡張子が正しくないです'},
                    size: {less_than: 5.megabytes, message: '5MB以下の画像にしてください'}
end
