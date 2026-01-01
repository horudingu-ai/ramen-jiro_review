class HomeController < ApplicationController
  def index
    @pickup_shops = Shop
      .joins(:menu_photos_attachments)
      .includes(menu_photos_attachments: :blob)
      .distinct
      .order(Arel.sql("RANDOM()"))
      .limit(5)
  end
end
