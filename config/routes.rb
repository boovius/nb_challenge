Rails.application.routes.draw do
  post '/event', to: 'events#create'
  get '/events', to: 'events#index', format: 'json'
  get '/summary', to:'events#summary', format: 'json'
end
