Rails.application.routes.draw do
  get  'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:show, :index, :create]
  get 'signup', to: 'users#new'
  root 'users#index'
end
