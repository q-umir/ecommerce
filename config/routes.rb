Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'pages/homepage'

  resources :product_likes, only: %i[index create destroy]

  resources :shopping_cart_products, only: %i[create destroy update]

  root to: "pages#homepage"

  resources :products do
    resources :reviews, only: :create
    resources :shopping_cart_products, only: :create # creando desde el show product
  end
end
