class Daily < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
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

    def create_notification_like!(visitor_user)
      #comment_idはnilでもいいし、checked: falseもそのままでいい
      #既にいいねされていなかをチェックしてされていたらそのまま返す
      #いいねの数だけ通知されたらいいね連打して通知を送りまくることができてしまう

      #visitor_user.active_notifications.buildの時点でvisitor_idにvisitor_user.idがは自動でセットされる
      #あとはいいねされる人を表すvisited_idにこの投稿の作成者であるself.user_idを入れて
            #どの投稿をいいねしたかを表すdaily_idにself.idを入れて
            #actionにlikeを入れる 
      #この場合のselfはcreate_notification_like!を呼び出したdailyインスタンス

      #自分の投稿の場合は通知済みとする
      #保存できるなら保存する（saveに失敗するとfalseが返り値になってしまうのを防ぐ）

      confirm_exists_like_notification = Notification.where(["visitor_id = ? and visited_id = ? and daily_id = ? and action = ?", visitor_user.id, self.user_id, self.id, 'like']) 
      
      if confirm_exists_like_notification.blank? 
        notification = visitor_user.active_notifications.build(
          visited_id: self.user_id,
          daily_id: self.id,
          action: 'like'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
      end
    end

    def create_notification_coment!(visitor_user, comment_id) 
      # 誰に通知を送るのか(visited_id)=>投稿者に対してだけではなく、他にコメントをしている人がいればその人にも
      # 誰が通知を送るのか(visitor_id)=>コメントを作成した人(メソッドの引数のvisitor_user)

      # notification = visitor_user.active_notification(visited_id: ???, daily_id: self.id, comment_id: self.comment_id, action: 'comment')
      # このままだとコメントしている人が複数人いた時にそのコメントしている人全員に通知が行かない（モデル側では実装できていない）
      # 日記の全てコメントを取得する（ただし自分でコメントしていたりする場合に自分のコメントは含めない）
      # ループ処理でvisited_idに各コメントのuser_idを入れていく 
      # XXXは複数のコメント
      # XXX.each do |YYY|
      #   notification = visitor_user.active_notification_comment!(visited_id: YYY[:user_id], daily_id: self.id, comment_id: self.comment_id, action: 'comment')

      # 自分が投稿した日記に自分でコメントした場合は通知済みとする
      # distinctで1人が複数のコメントをしていた時にも一つとしてカウントする(:user_idの重複防ぐ)

      comment_users = Comment.select(:user_id).where(daily_id: self.id).distinct

      save_notification_comment!(visitor_user, comment_id, comment_users)

      # もしまだ誰もコメントしていなかったら日記の作成者に通知を送る
      # これはリファクタしたらわかりづらくなるからあえてしない
      if comment_users.blank?
        notification = visitor_user.active_notifications.build(
            visited_id: self.user_id,
            daily_id: self.id,
            comment_id: comment_id,
            action: 'comment'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        
        notification.save if notification.valid?
      end
    end
      
    def save_notification_comment!(visitor_user, comment_id, comment_users)
      comment_users.each do |comment_user|
        notification = visitor_user.active_notifications.build(
          visited_id: comment_user[:user_id],
          daily_id: self.id,
          comment_id: comment_id,
          action: 'comment'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        
        notification.save if notification.valid?
      end

      
    end
end
