class SessionsController < ApplicationController
  def new; end
 def create
  email = params[:email].to_s.strip.downcase
  password = params[:password].to_s

  user = User.find_by(email: email)

  if user&.authenticate(password)
  session[:user_id] = user.id
  redirect_to(session.delete(:return_to) || root_path, notice: "ログインしました")
  else
    flash.now[:alert] = "メールアドレスかパスワードが違います"
    render :new, status: :unprocessable_entity
  end
end


  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end