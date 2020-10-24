class Relationship < ApplicationRecord
  # belongs_to :follower
  # followerメソッドでRelationshipモデルのfollower_idと
  # followrモデルのidに一致するカラムをfollowrモデルから取得する状態
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
