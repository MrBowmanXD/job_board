Rails.application.routes.draw do
  get 'jobs/search', to: 'jobs#search', as: 'search_jobs'
  root to: 'jobs#index'
  devise_for :users
  resources :jobs do
    resources :applications do
      member do 
        patch 'application', to: 'applications#update'
      end
    end
  end
end
