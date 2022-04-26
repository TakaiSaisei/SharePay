Rails.application.routes.draw do
  resources :debts, only: %i[index show]
  resources :payments, only: %i[index create]
  resources :purchases, except: %i[update destroy]
  resources :users, except: %i[create]

  namespace :auth do
    post :login
  end
end
