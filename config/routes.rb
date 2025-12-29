Rails.application.routes.draw do
  root "shops#index"

  # 認証
  get    "/signup", to: "users#new"
  post   "/signup", to: "users#create"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # ユーザー
 get "/users/new", to: "users#new", as: :new_user


  # 店舗（CRUD） + 口コミ（店舗に紐づく）
  resources :shops do
    resources :reviews, only: [:new, :create]
    collection do
    get :photos
  end
end
end
