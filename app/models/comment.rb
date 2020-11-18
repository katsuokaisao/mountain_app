class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :daily
  validates :content, presence: true
end
