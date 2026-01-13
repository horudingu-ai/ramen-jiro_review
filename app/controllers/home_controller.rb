class HomeController < ApplicationController
  @recent_review_shops = Shop
  .joins(:reviews)
  .includes(menu_photos_attachments: :blob) # reviews は含めない
  .select("shops.*, MAX(reviews.created_at) AS last_reviewed_at")
  .group("shops.id")
  .order(Arel.sql("last_reviewed_at DESC"))
  .limit(5)

  @pickup_shops = base.to_a.sample(5)

   # 新着店舗（最新5件）
    @new_shops = Shop.order(created_at: :desc).limit(5)

    # 口コミ新着店舗（最新の口コミから店舗を重複なしで5件）
    @recent_review_shops = Shop
      .joins(:reviews)
      .includes(menu_photos_attachments: :blob)
      .select("shops.*, MAX(reviews.created_at) AS last_reviewed_at")
      .group("shops.id")
      .order(Arel.sql("last_reviewed_at DESC"))
      .limit(5)
    end
end
