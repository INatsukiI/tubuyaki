class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :likes

  validates :content, presence: true, length: { in: 1..20 }
end
