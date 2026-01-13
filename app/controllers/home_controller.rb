class HomeController < ApplicationController
  def index
    base = Shop
      .left_joins(menu_photos_attachments: :blob)
      .includes(menu_photos_attachments: :blob)
      .distinct

    # Pick up（画像付き店舗からランダム）
    @pickup_shops = base.to_a.sample(5)

    # 新着店舗（最新5件）
    @new_shops = Shop.order(created_at: :desc).limit(5)

    # 口コミ新着店舗（最新口コミ日時で5件）
    @recent_review_shops = Shop
      .joins(:reviews)
      .select("shops.*, MAX(reviews.created_at) AS last_reviewed_at")
      .group("shops.id")
      .order(Arel.sql("last_reviewed_at DESC"))
      .limit(5)
  end
end