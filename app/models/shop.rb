class Shop < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews, dependent: :destroy

  has_one_attached :building_photo
  has_many_attached :menu_photos

  validates :name, presence: true
  validates :address, presence: true
  validate :menu_photos_count_within_limit
def open_now?(now = Time.zone.now)
    return false if business_hours.blank?

    now_min = now.hour * 60 + now.min

    business_hours.split("/").any? do |range|
      m = range.strip.match(/(\d{1,2}):(\d{2})\s*~\s*(\d{1,2}):(\d{2})/)
      next false unless m

      sh, sm, eh, em = m.captures.map(&:to_i)
      start_min = sh * 60 + sm
      end_min   = eh * 60 + em

      if start_min <= end_min
        now_min.between?(start_min, end_min)
      else
        now_min >= start_min || now_min <= end_min
      end
    end
  end

  private

  def menu_photos_count_within_limit
    if menu_photos.attachments.size > 5
      errors.add(:menu_photos, "は最大5枚までです")
    end
  end
end
