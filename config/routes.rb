Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :users, only: %i(new create)
    resources :tours, only: %i(index show)
    resources :tour_requests, only: %i(create destroy)
    namespace :admin do
      resources :users, only: %i(index edit update destroy)
      resources :tours
      resources :reviews
      resources :tour_requests
    end
  end
end
