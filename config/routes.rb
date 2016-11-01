Rails.application.routes.draw do
  resources :merchants

  namespace :dji_track do
    root to: 'visitors#index'
    resources :orders, except: [:edit, :update, :destroy]
  end

  devise_for :users
  resources :users

  get '/orders', to: redirect('/dji_track/orders')
  get '/orders/new', to: redirect('/dji_track/orders/new')

  root to: 'visitors#index'

  constraints(host: /dji-track.herokuapp.com/) do
    match "/(*path)" => redirect { |params, req| "//www.dronehome.io/#{params[:path]}" },  via: [:get, :post]
  end
end
