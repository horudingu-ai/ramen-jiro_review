class User < ApplicationRecord
    has_one_attached :icon
  has_secure_password
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :gender, inclusion: { in: %w[male female] }, allow_nil: true
validates :age,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 120 },
    allow_nil: true
  validate :age_must_be_multiple_of_5

  private

  def age_must_be_multiple_of_5
    return if age.nil?
    errors.add(:age, "は5歳刻みで入力してください") unless (age % 5).zero?
  end
end
