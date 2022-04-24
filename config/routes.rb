Rails.application.routes.draw do
  resources :payments
  resources :purchases
  resources :users, except: %i[create] do
    get :purchases
  end

  namespace :auth do
    post :login
  end
end
