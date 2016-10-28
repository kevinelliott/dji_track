Rails.application.routes.draw do
  resources :orders, except: [:edit, :update, :destroy]

  devise_for :users
  resources :users

  root to: 'visitors#index'
end
