Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :suppliers
  resources :purchasing_requests do
    resources :purchasing_request_items, only: [:create, :update, :destroy]
  end
  resources :restaurants
  resources :storage_locations do
    resources :items, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :wines
  resources :locations do
    collection do
      get :map
    end
  end
end
