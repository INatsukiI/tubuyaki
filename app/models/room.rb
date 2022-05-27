class Room < ApplicationRecord
  has_many :entrie, dependent: :destroy
  has_many :messages, dependent: :destroy
end
