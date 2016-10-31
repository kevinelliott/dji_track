Rails.application.routes.draw do
  resources :merchants
  resources :orders, except: [:edit, :update, :destroy] do
    collection do
      get :update_dji_orders
      get :update_tracking
    end
  end

  devise_for :users
  resources :users

  root to: 'visitors#index'
end
