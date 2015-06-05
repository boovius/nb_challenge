Rails.application.routes.draw do
  post '/event', to: 'events#create'
  get '/events', to: 'events#index', format: 'json'
end
