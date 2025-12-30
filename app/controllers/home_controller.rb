class HomeController < ApplicationController
  def index
    @new_shops = Shop.order(created_at: :desc).limit(6)
  end
end
