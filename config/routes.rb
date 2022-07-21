Rails.application.routes.draw do
  devise_for :users
  get 'pages/homepage'
  root to: "pages#homepage"
end
