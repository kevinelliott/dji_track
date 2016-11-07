Rails.application.routes.draw do

  namespace :dji_track do
    resources :orders, except: [:edit, :update, :destroy] do
      collection do
        get 'chart_data', as: :chart_data
      end
    end
    root to: 'visitors#index'
  end

  resources :manufacturers
  constraints(host: /dji-track.herokuapp.com/) do
    match "/(*path)" => redirect { |params, req| "//www.dronehome.io/#{params[:path]}" },  via: [:get, :post]
  end
  
  resources :merchants

  namespace :news do
    resources :articles
    root to: 'articles#index'
  end

  resources :products

  resources :terms
  get 'terminology', to: 'terminology#index', as: :terminology

  devise_for :users
  resources :users

  get '/orders', to: redirect('/dji_track/orders')
  get '/orders/new', to: redirect('/dji_track/orders/new')

  root to: 'visitors#index'
end
