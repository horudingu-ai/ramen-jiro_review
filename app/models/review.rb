class Review < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :shop
  has_many_attached :images

  enum :age_group, {
    age_unknown: 0,
    teens: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties_plus: 6
  }

  enum :gender, {
    gender_unknown: 0,
    male: 1,
    female: 2,
    other: 3
  }

  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :body, presence: true
end

