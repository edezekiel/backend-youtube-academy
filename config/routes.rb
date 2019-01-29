Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :index]
      get '/', to 'auth', to: 'auth#check'
      get '/oauth2callback', to: 'auth#login'
    end
  end
end
