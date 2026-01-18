class ShopsController < ApplicationController
  before_action :set_shop, only: [:show, :edit, :update, :destroy, :detailed_review, ]
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
scope = scope.with_attached_building_photo.with_attached_menu_photos

    if params[:open_now] == "1"
      scope = scope.to_a.select { |shop| shop.open_now? }
    end

    @shops = scope

  @pickup_shops = Shop
    .joins(:menu_photos_attachments)
    .includes(menu_photos_attachments: :blob)
    .distinct
    .order(Arel.sql("RANDOM()"))
    .limit(5)
end
  def show
     @shop = Shop.find(params[:id])
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
def detailed_review
  base_all = @shop.reviews

  # 一括表示（年代別）
  @by_age = Review.age_groups.keys.index_with do |age|
    rel = base_all.where(age_group: age)
    {
      count: rel.count,
      overall: rel.average(:rating)&.to_f,
      taste: rel.average(:rating_taste)&.to_f,
      service: rel.average(:rating_service)&.to_f,
      value: rel.average(:rating_value)&.to_f,
      cleanliness: rel.average(:rating_cleanliness)&.to_f,
      atmosphere: rel.average(:rating_atmosphere)&.to_f
    }
  end

  @by_gender = Review.genders.keys.index_with do |g|
    rel = base_all.where(gender: g)
    {
      count: rel.count,
      overall: rel.average(:rating)&.to_f,
      taste: rel.average(:rating_taste)&.to_f,
      service: rel.average(:rating_service)&.to_f,
      value: rel.average(:rating_value)&.to_f,
      cleanliness: rel.average(:rating_cleanliness)&.to_f,
      atmosphere: rel.average(:rating_atmosphere)&.to_f
    }
  end

  base = base_all
  base = base.where(age_group: params[:age_group]) if params[:age_group].present?
  base = base.where(gender: params[:gender]) if params[:gender].present?

  @count = base.count
  @avg_overall = base.average(:rating)&.to_f
  @category_avgs = {
    taste: base.average(:rating_taste)&.to_f,
    service: base.average(:rating_service)&.to_f,
    value: base.average(:rating_value)&.to_f,
    cleanliness: base.average(:rating_cleanliness)&.to_f,
    atmosphere: base.average(:rating_atmosphere)&.to_f
  }
end
end
private
  def set_shop
    @shop = Shop.find(params[:id])
  end
 def shop_params
  params.require(:shop).permit(
    :name, :address, :business_hours, :closed_days, :access, :notes,
    :building_photo,
    menu_photos: []
  )
end
