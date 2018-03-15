Rails.application.routes.draw do
  namespace :api do
    resources :stock_keeping_units, only: [:create]
    resources :inventories, only: [] do
      collection do
        post :addition
        post :reduction
        post :reserve
        get :current_stock_on_hand
        get :current_pending_shipped
      end
    end
  end
end
