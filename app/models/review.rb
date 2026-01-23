class Review < ApplicationRecord
  belongs_to :user, optional: true       #optional: trueは匿名okにする
  belongs_to :shop
  has_many_attached :images

  #年齢カラム
  enum :age_group, {
    age_unknown: 0,
    teens: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties_plus: 6
  }
  #性別カラム
  enum :gender, {
    gender_unknown: 0,
    male: 1,
    female: 2,
    other: 3
  }
  #保存するための条件=validates
validates :rating, presence: true, inclusion: { in: 1..5 }    #inclusionで1から5の範囲に制限、
  validates :body, presence: true         #presence: trueで必須
end

