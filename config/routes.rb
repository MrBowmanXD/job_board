Rails.application.routes.draw do
  root to: 'jobs#index'
  devise_for :users
  resources :jobs
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
