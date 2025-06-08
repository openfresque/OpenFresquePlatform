Rails.application.routes.draw do
  namespace :admin do
      resources :training_sessions
      resources :users
      resources :smtp_settings
      resources :color_settings
      resources :open_fresk_settings
      resources :products
      resources :product_configurations
      resources :product_configuration_sessions, only: %i[index show edit update]

      root to: "users#index"
    end
  root to: "training_sessions#index"

  mount OpenFresk::Engine => "/"

  resources :training_sessions
  resources :session_participations, only: %i[show]
end
