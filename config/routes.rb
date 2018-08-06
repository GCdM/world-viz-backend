Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :countries
      get '/countries/:id/:extra', to: 'countries#extra'
      root 'countries#index'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
