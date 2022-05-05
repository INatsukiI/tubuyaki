class Article < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { in: 1..20 }
end
