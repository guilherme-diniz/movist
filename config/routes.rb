Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' , registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :movies do
    get '/', action: :index
    post '/', action: :index
    get '/show/:id', action: :show, as: 'show'
    post '/seen', action: :seen
    post '/unseen', action: :unseen
    post '/rate', action: :rate
  end

  namespace :lists do
    get '/', action: :index
    post '/', action: :index
    get '/show/:id', action: :show, as: 'show'
    post '/new', action: :new
    post '/addTo', action: :add_to
    delete '/:id', action: :delete, as: 'delete'
  end

  namespace :users do
    get '/profile', action: :profile
  end

  namespace :recommendations do
    get '/', action: :index
    get '/check', action: :check_recommendations
    post '/rate', action: :rate
  end

  root to: 'main#index'
end
