Rails.application.routes.draw do
  resources :categories
  devise_for :users
  get 'pages/homepage'
  root to: "pages#homepage"
end
