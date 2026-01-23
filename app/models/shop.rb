class Shop < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many :reviews, dependent: :destroy  #店舗を消したら、全部削除
  has_one_attached :building_photo     #has_one_attachedは1つだけ持てる
  has_many_attached :menu_photos       #has_many_attachedは複数持ち可能
  validates :name, presence: true
  validates :address, presence: true
  validate :menu_photos_count_within_limit

  # 営業中かどうかを判定する
def open_now?(now = Time.zone.now)
    return false if business_hours.blank?

    # 現在の時刻を分単位で計算
    now_min = now.hour * 60 + now.min
    # /で区切られた営業時間の
    business_hours.split("/").any? do |range|
      # 各営業時間の開始・終了時刻を抽出
      m = range.strip.match(/(\d{1,2}):(\d{2})\s*~\s*(\d{1,2}):(\d{2})/)
      next false unless m
    #時刻を数値に変換,開始・終了時刻を「分」に変換
      sh, sm, eh, em = m.captures.map(&:to_i)
      start_min = sh * 60 + sm
      end_min   = eh * 60 + em

    # 営業時間が日を跨ぐ場合を考慮
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
