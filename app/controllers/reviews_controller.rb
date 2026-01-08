class ReviewsController < ApplicationController
  before_action :set_shop
       def new
          @review = @shop.reviews.new
  end
       def create
    @review = @shop.reviews.new(review_params)
    if logged_in?
    @review.user = current_user
    @review.author_name = current_user.name.presence || "guest"
  else
    @review.user = nil
    @review.author_name = "guest"
  end
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
  params.require(:review).permit(:visit_date,:title,:body,:rating,:gender,:age,images: [])
end  
end
