Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index]
      resources :outlines, only: [:show, :create, :destroy]
      post '/useroutlines', to: 'outlines#useroutlines'
      post '/login', to: 'login#login', as: 'login'
    end
  end
end
