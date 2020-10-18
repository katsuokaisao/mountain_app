class Daily < ApplicationRecord
  belongs_to :user
  belongs_to :mountain
  validates :mountain_name, presence: true, length: {maximum: 30}
  validates :title, presence: true, length: {maximum: 30}
  validates :comment, presence: true, length: {maximum: 600}
end
