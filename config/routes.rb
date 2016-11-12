Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/internal_server_error'

  namespace :admin do
    resources :users

    resources :articles
    resources :manufacturers
    resources :merchants
    resources :orders
    resources :order_state_logs
    resources :products
    resources :streaming_sites
    resources :terms
    resources :videos

    root to: "users#index"
  end

  get 'about/index', as: :about

  namespace :dji_track do
    resources :orders, except: [:edit, :update, :destroy] do
      collection do
        get 'chart_data', as: :chart_data
        get 'recent', as: :recent
      end
      member do
        get 'history', as: :history
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

  resources :order_state_logs

  resources :products

  resources :streaming_sites, except: [:edit, :update, :destroy]

  resources :terms
  get 'terminology', to: 'terminology#index', as: :terminology

  devise_for :users
  resources :users

  resources :videos, except: [:edit, :update, :destroy]

  get '/orders', to: redirect('/dji_track/orders')
  get '/orders/new', to: redirect('/dji_track/orders/new')

  # Errors
  match '/404', to: 'errors#not_found', via: :all, as: :error_404
  match '/500', to: 'errors#internal_server_error', via: :all, as: :error_500

  root to: 'visitors#index'
end
