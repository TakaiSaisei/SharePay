Rails.application.routes.draw do
  resources :payments, except: %i[update destroy]
  resources :purchases, except: %i[update destroy]
  resources :users, except: %i[create]

  namespace :auth do
    post :login
  end
end
