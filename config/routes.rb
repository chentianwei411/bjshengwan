require 'sidekiq/web'

Rails.application.routes.draw do
  get '/profile', to: 'profile#index'

  resources :products do
    collection do
      get 'label'
      get 'label/LRD2100' , to: 'products#label2100'
      get 'label/LRD6300' , to: 'products#label6300'
      get 'label/LRD8200' , to: 'products#label8200'
      get 'eddy'

      get 'eddy/ecl202' , to: 'products#ecl202'
      get 'eddy/ecl150' , to: 'products#ecl150'
      get 'eddy/ecl101' , to: 'products#ecl101'
      get 'eddy/eca101' , to: 'products#eca101'

      get 'capacitor'
      get 'spindle'
      get "spindle/sea", to: 'products#spindlesea'
      get "spindle/sci", to: 'products#spindlesci'
    end
  end

  resources :projects
  namespace :admin do
      resources :users
      resources :announcements
      resources :notifications
      resources :services

      root to: "users#index"
    end
  get '/privacy', to: 'home#privacy'
  get '/terms', to: 'home#terms'
  resources :notifications, only: [:index]
  resources :announcements, only: [:index]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
