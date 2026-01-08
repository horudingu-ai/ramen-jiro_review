class Shop < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews, dependent: :destroy

  has_one_attached :building_photo
  has_many_attached :menu_photos

  validates :name, presence: true
  validates :address, presence: true
  validate :menu_photos_count_within_limit

  private

  def menu_photos_count_within_limit
    if menu_photos.attachments.size > 5
      errors.add(:menu_photos, "は最大5枚までです")
    end
  end
end
