Rails.application.routes.draw do
  get 'toppages/index'
  root to: 'tasks#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :tasks, only: [:create, :destroy]
  resources :users
end
