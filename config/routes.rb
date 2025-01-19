Rails.application.routes.draw do
  root "landings#index"
  # Authentication
  resource :session, only: [ :create ]
  get "/login", to: "sessions#new", as: :login
  delete "/logout", to: "sessions#destroy", as: :logout
  resources :registrations, only: [ :new, :create ]
  get "/signup", to: "registrations#new", as: :signup
  resources :passwords, param: :token
  # Expenses
  resources :expenses
  # Charts
  scope :charts do
    get "income", to: "charts#income", as: :charts_income
    get "spendings", to: "charts#spendings", as: :charts_spendings
    get "profits", to: "charts#profits", as: :charts_profits
  end
  # Dashboard Analytics
  resource :dashboard_analytics, only: [ :show ]
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
