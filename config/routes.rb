Rails.application.routes.draw do
  resources :debts, only: %i[index show]
  resources :payments, only: %i[index create]
  resources :purchases

  namespace :auth do
    post :login
  end
end
