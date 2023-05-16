Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :suppliers
  resources :restaurants
  resources :wines

  resources :purchasing_requests do
    resources :purchasing_request_items, only: [:create, :update, :destroy]

    member do
      post :approve
      post :reject
      post :request_more_info
      post :create_note
    end
  end

  resources :storage_locations do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :notifications, only: [:index]
end
