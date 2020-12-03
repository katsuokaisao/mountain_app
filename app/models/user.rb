class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  has_many :dailys, dependent: :destroy
  has_one  :profile, dependent: :destroy
  has_many :likes, dependent: :destroy
  # UserモデルのidとLikeモデルのuser_idが一致するカラムをLikeカラムから取得する
  has_many :like_posts, through: :likes, source: :daily
  has_many :comments, dependent: :destroy

  # has_many :active_notifications #自分から他の人に通知を送る
  # active_notificationsメソッドでactiveNotificationモデルのuser_idにこのモデルのidをセットする状態
  # =>notificationモデルに対してセットしたい=>user_idは存在しない（visitor_idにセットして欲しい）
  # active_notificationsメソッドでNotificationモデルのvisitor_idにこのモデルのidをセットする状態が理想、またUserを削除した時にNotificationsも削除したい
  # passive_notificationsメソッドでNotificationsモデルのvisited_idにこのモデルのidをセットする状態が理想、またUserを削除した時にNotificationsも削除したい

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id',
                                  dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id',
                                   dependent: :destroy

  # has_many :active_relationships
  # active_relationshipsメソッドで
  # Userモデルのidとactiverelationshipモデルのuser_idが一致するカラムを
  # activerelationshipモデルから取得する状態

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id',
                                  dependent: :destroy
  # Relationshipモデルのfollower_idがUserのidが一致するカラムを取得する
  # そのカラムのfollowed_idとUserのidが一致するUserを取得すればフォローしている人を取得できる
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  # DM機能の実装
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy

  def self.guest
    find_or_create_by!(username: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def follow?(other_user)
    !!active_relationships.find_by(followed_id: other_user.id)
  end

  def create_notification_follow!(visitor_user)
    confirm_exists_follow_notification = Notification.where(['visitor_id = ? and visited_id = ?
    and action = ?', visitor_user.id, id, 'follow'])
    return if confirm_exists_follow_notification.present?

    notification = visitor_user.active_notifications.new(
      # visitor_id: user.id
      visited_id: id,
      action: 'follow'
    )
    notification.save if notification.valid?
    # 自分で自分をフォローすることはありえない
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
  end
end
