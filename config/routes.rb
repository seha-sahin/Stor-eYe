Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  resources :suppliers
  resources :restaurants
  resources :wines

  resources :purchasing_requests do
    resources :purchasing_request_items, only: [:create, :update, :destroy]

    member do
      put :approve
      post :approve_notification
      put :reject
      post :reject_notification
      put :request_more_info
      post :request_more_info_notification
      post :create_note
    end
  end

  resources :storage_locations do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :wines
  resources :locations do
    collection do
      get :map
    end
  end

  resources :notifications, only: [:index]
end
