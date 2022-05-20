class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_one_attached :image

  validates :content, presence: true, length: { in: 1..20 }
end
