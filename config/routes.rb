Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/login', to: 'users#login', as: 'login'
      resources :outlines, only: [ :create ]
      resources :notebooks, only: [:show, :create ]
      resources :outline_notes, only: [:show, :create]
    end
  end
end
