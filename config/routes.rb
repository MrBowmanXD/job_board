Rails.application.routes.draw do
  get 'donate/payment'
  get 'pages/home'
  get 'pages/about'
  get 'pages/contact'
  resources :messages, only: [:create]
  get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
  get 'dashboard/:id', to: 'dashboard#show', as: 'user_profile'
  get 'jobs/search', to: 'jobs#search', as: 'search_jobs'
  root to: 'pages#home'
  devise_for :users
  resources :jobs do
    resources :applications, only: [:create, :edit, :update, :destroy] do
      member do
        patch 'application', to: 'applications#update'
        delete 'delete', to: 'applications#destroy'
      end
    end
  end
end
