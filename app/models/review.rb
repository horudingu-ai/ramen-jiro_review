class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  has_many_attached :images
  validates :rating, inclusion: { in: 1..5 }
  validates :body, presence: true
  enum :gender, { male: 0, female: 1 }, prefix: true
  validates :age,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 120 },
    allow_nil: true
end
