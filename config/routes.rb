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
      resources :api_tokens
      resources :participations
      
      root to: "users#index"
    end
  root to: "training_sessions#index"

  resources :training_sessions do
    member do
      get :product_configurations
      post :set_product_configurations
      get :show_public
    end

    collection do
      get :public
    end

    resources :public_participations, only: %i[create] do
      collection do
        get :ticket_choice
        post :personal_informations
        patch :update
      end
    end
  end

  resources :payments, only: %i[new create] do
    collection do
      post :create_payment_intent
      get :confirmation
      post :stripe_webhook
    end
  end

  mount OpenFresk::Engine => "/"
end
