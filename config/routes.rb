Rails.application.routes.draw do
  namespace :admin do
      resources :training_sessions
      resources :users
      resources :smtp_settings
      resources :open_fresk_settings

      root to: "users#index"
    end
  root to: "training_sessions#index"

  mount OpenFresk::Engine => "/"

  resources :training_sessions
  resources :session_participations, only: %i[show]
end
