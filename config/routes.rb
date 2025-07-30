require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions'
  }

  authenticate :user, ->(user) { user.confirmed? && user.admin_role? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.haml)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "recipients#index"

  get :about, to: 'home#about'
  get :calendar, to: 'home#calendar'

  resources :recipients do
    patch :generate_ideas, on: :member
    get :event_dates, on: :collection

    resources :recipient_ideas, only: :destroy, controller: 'recipients/recipient_ideas' do
      post :reorder, on: :collection
    end
  end

  get "dashboard", to: "dashboard#index"
end
