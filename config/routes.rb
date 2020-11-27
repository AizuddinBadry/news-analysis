
Rails.application.routes.draw do
  resources :storages
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'pages#home'
  get 'pages/dashboard'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end