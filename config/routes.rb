
Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root 'pages#home'
  get 'pages/account'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end