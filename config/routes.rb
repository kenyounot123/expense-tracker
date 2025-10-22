Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"
  root "landings#index"

  # Static pages
  get "/privacy", to: "landings#privacy", as: :privacy
  get "/terms", to: "landings#terms", as: :terms

  # Authentication
  resource :session, only: [ :create ]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  resources :registrations, only: [ :new, :create ]
  get "/signup", to: "registrations#new", as: :signup
  resources :passwords, param: :token
  namespace :auth do
    get "/google_oauth/authorize", to: "google_oauth#authorize", as: :google_oauth_authorize
    get "/google_oauth/callback", to: "google_oauth#callback", as: :google_oauth_callback
  end

  # Expenses
  resources :expenses
  resources :searches, only: :index

  # Charts
  scope :charts do
    get "income", to: "charts#income", as: :charts_income
    get "spendings", to: "charts#spendings", as: :charts_spendings
    get "profits", to: "charts#profits", as: :charts_profits
    get "category_breakdown", to: "charts#category_breakdown", as: :charts_category_breakdown
  end

  # Categories
  namespace :category do
    resources :breakdowns, only: [ :index, :show ]
  end

  resources :categories
  post "categories/create_from_select", to: "categories#create_from_select"
  post "categories/apply_category", to: "categories#apply_category"
  # Dashboard Analytics
  resource :dashboard_analytics, only: :show

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
