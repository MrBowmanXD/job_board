Rails.application.routes.draw do
  resources :users, only: [:show, :index,:new, :create]
  root 'users#index'
end
