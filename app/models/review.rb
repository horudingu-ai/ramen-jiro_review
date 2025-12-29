class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop

  has_many_attached :images

  validates :rating, inclusion: { in: 1..5 }
  validates :body, presence: true
end
