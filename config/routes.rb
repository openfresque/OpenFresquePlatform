Rails.application.routes.draw do
  namespace :admin do
      resources :training_sessions
      resources :users
      resources :smtp_settings

      root to: "users#index"
    end
  root to: "training_sessions#index"

  mount OpenFresk::Engine => "/"
end
