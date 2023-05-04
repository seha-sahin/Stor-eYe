Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers
  resources :purchasing_requests
  resources :restaurants
  resources :storage_locations do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :wines
end
