class Mountain < ApplicationRecord
  has_many :dailys, dependent: :destroy
end
