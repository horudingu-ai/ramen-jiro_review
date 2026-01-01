Rails.application.routes.draw do
 root "home#index"
  # 認証
  get    "/signup", to: "users#new"
  post   "/signup", to: "users#create"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 店舗の写真一覧（/shops/:id より先に書くのが重要）
  get "/shops/photos", to: "shops#photos", as: :photos_shops

  # 店舗（CRUD） + 口コミ（店舗に紐づく）
  resources :shops do
    resources :reviews, only: [:new, :create]
  end
end
