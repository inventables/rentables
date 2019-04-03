Rails.application.routes.draw do
  root to: "vehicles#index"
  resources :vehicles, only: :index
  resources :reservations, only: [:index, :new, :create]
end
