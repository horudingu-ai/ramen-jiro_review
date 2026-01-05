class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # 登録後にログインさせたいなら session[:user_id] = @user.id など
      redirect_to root_path, notice: "登録しました"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end
 def account
    @user = current_user
  end
  def edit
  @user = current_user
end

def update
  @user = current_user
  if @user.update(user_params)
    redirect_to account_path
  else
    render :edit, status: :unprocessable_entity
  end
end
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :location, :icon)
  end
end
