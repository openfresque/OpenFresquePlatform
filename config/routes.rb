Rails.application.routes.draw do
  resources :countries
  resources :languages
  namespace :admin do
      resources :training_sessions
      resources :users
      resources :smtp_settings

      root to: "users#index"
    end
  root to: "training_sessions#index"

  mount OpenFresk::Engine => "/"

  resources :training_sessions
end
