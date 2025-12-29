module ApplicationHelper
  def stars(rating)
    "★" * rating.to_i + "☆" * (5 - rating.to_i)
  end
end
