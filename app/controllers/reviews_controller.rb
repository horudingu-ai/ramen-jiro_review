class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_shop
       def new
          @review = @shop.reviews.new
  end
       def create
    @review = @shop.reviews.new(review_params)
    @review.user = current_user
       if @review.save
      redirect_to shop_path(@shop), notice: "口コミを投稿しました"
       else
      render :new, status: :unprocessable_entity
    end
  end
  private
      def set_shop
    @shop = Shop.find(params[:shop_id])
      end

      def review_params
    params.require(:review).permit(:rating, :body, :visit_date, images: [])
      end
end
