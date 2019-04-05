Rails.application.routes.draw do
  root to: "vehicles#index"
  resources :vehicles, only: [:index, :new, :create]
  resources :reservations, only: [:index, :new, :create]
end
