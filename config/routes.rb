Rails.application.routes.draw do
  namespace :api do
    resources :stock_keeping_units, only: [:create]
  end
end
