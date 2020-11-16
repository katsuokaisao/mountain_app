class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  has_many :dailys, dependent: :destroy
  has_one  :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  # UserモデルのidとLikeモデルのuser_idが一致するカラムをLikeカラムから取得する
  has_many :like_posts, through: :likes, source: :daily

  # has_many :active_relationships
  # active_relationshipsメソッドで
  # Userモデルのidとactiverelationshipモデルのuser_idが一致するカラムを
  # activerelationshipモデルから取得する状態

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  # Relationshipモデルのfollower_idがUserのidが一致するカラムを取得する
  # そのカラムのfollowed_idとUserのidが一致するUserを取得すればフォローしている人を取得できる
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def self.guest
    find_or_create_by!(username: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  def follow(other_user)
    self.active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def follow?(other_user)
    !!self.active_relationships.find_by(followed_id: other_user.id)
  end

end
