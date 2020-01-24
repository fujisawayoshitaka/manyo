Rails.application.routes.draw do
  resources :labels
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
      resources :users
  end
  resources :users, only: [:new, :create, :show, :destroy]
  resources :tasks
  root 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
