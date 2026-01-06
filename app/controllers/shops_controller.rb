class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy]
 before_action :require_login, only: [:new, :create]

  def index
  @q = params[:q].to_s
  @sort = params[:sort].to_s

  scope = Shop.all
  scope = scope.where(
    "name LIKE ? OR area LIKE ? OR address LIKE ?",
    "%#{@q}%", "%#{@q}%", "%#{@q}%"
  ) if @q.present?

  scope =
    case @sort
    when "new" then scope.order(created_at: :desc)
    when "old" then scope.order(created_at: :asc)
    else scope.order(created_at: :desc)
    end
@shops = scope.with_attached_building_photo.with_attached_menu_photos

  @pickup_shops = Shop
    .joins(:menu_photos_attachments)
    .includes(menu_photos_attachments: :blob)
    .distinct
    .order(Arel.sql("RANDOM()"))
    .limit(5)
end
  def show
  @reviews = @shop.reviews.includes(:user).order(created_at: :desc)
end
  
  def new
    @shop = Shop.new
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to @shop, notice: "店舗を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @shop.update(shop_params)
      redirect_to @shop, notice: "店舗を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @shop.destroy
    redirect_to shops_path, notice: "店舗を削除しました"
  end
 def photos
  @photos = ActiveStorage::Attachment
    .includes(:record, :blob)
    .where(record_type: "Shop", name: "menu_photos")
    .order(created_at: :desc)
end
private
  def set_shop
    @shop = Shop.find(params[:id])
  end

 def shop_params
  params.require(:shop).permit(
    :name, :area, :address, :business_hours, :closed_days, :access, :notes, :building_photo,
    menu_photos: []
  )
end
end