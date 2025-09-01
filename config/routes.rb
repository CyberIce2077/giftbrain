require "sidekiq/web"
require "sidekiq-scheduler/web"

Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    sessions: "users/sessions"
  }

  authenticate :user, ->(user) { user.confirmed? && user.admin_role? } do
    mount Sidekiq::Web => "/sidekiq"
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

  get :about, to: "home#about"
  get :calendar, to: "home#calendar"

  resources :recipients do
    resources :teams, only: %i[new create edit update], controller: "recipients/teams"
    patch :generate_ideas, on: :member
    get :event_dates, on: :collection
  end

  resources :recipient_ideas, only: :destroy do
    post :reorder, on: :collection
  end

  namespace :users do
    resources :unsubscribe, only: %i[index create]
  end

  resources :teams, only: %i[index show destroy] do
    resources :team_members, only: %i[new create], controller: "teams/team_members"

    member do
      get :invitations
      get :public_join
      get :copy_public_link
      patch "invitations/accept", to: "teams#accept"
      patch "invitations/decline", to: "teams#decline"
    end
  end

  resources :team_members, only: %i[destroy]
end
