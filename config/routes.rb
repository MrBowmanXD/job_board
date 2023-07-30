Rails.application.routes.draw do
  resources :messages
  get 'dashboard/index', to: 'dashboard#index', as: 'dashboard'
  get 'dashboard/:id', to: 'dashboard#show', as: 'user_profile'
  get 'jobs/search', to: 'jobs#search', as: 'search_jobs'
  root to: 'jobs#index'
  devise_for :users
  resources :jobs do
    resources :applications do
      member do
        patch 'application', to: 'applications#update'
        delete 'delete', to: 'applications#destroy'
      end
    end
  end
end
