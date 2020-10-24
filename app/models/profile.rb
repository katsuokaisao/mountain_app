class Profile < ApplicationRecord
  belongs_to :user,  dependent: :destroy
  has_one_attached :avatar,  dependent: :destroy
end
