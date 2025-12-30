Rails.application.routes.draw do
  get "home/index"
  get "photos/index"
  root "shops#index"
 resources :shops
  # 認証
  get    "/signup", to: "users#new"
  post   "/signup", to: "users#create"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # ユーザー
 get "/users/new", to: "users#new", as: :new_user

resources :photos, only: [:index]
  # 店舗（CRUD） + 口コミ（店舗に紐づく）
  resources :shops do
    resources :reviews, only: [:new, :create]
    resources :photos, only: [:index]
    collection do
    get :photos
  end
end
end
