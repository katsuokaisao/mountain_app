class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  # scope, :latest_order -> { order(created_at: desc) }
  # vistitorメソッドでNotificationモデルのnotification_idとVisitorモデルのidが一致するものを取得する=>VisitorモデルじゃなくてUserモデルを対象にしたいから=>notification_idじゃなくてvisitor_idを対象にして欲しい
  #理想はNotificationモデルのvisitor_idとUserモデルのidが一致するカラムを取得して欲しい
  # optional: trueはnilでもいい
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :daily, optional: true
  belongs_to :comment, optional: true
end