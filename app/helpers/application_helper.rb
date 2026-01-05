module ApplicationHelper
  def stars(rating)
    "★" * rating.to_i + "☆" * (5 - rating.to_i)
  end
def age_range(age)
    return "未設定" if age.blank?

    "#{age}〜#{age + 4}"
  end
end
