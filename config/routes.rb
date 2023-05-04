Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers
  resources :purchasing_requests
  resources :wines
end
