class Room < ApplicationRecord
  has_many :messages, depent: :destroy
  has_many :entries, dependent: :destroy
end
