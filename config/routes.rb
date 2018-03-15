Rails.application.routes.draw do
  namespace :api do
    resources :stock_keeping_units, only: [:create]
    resources :inventories, only: [] do
      collection do
        post :addition
        post :reduction
      end
    end
  end
end
