Rails.application.routes.draw do
  get  'login', to: 'sessions#new'
  resources :sessions, only: [:destroy, :create]
  resources :users, only: [:show, :index, :create]
  get 'signup', to: 'users#new'
  root 'users#index'
end
