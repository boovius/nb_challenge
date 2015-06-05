Rails.application.routes.draw do
  post '/event', to: 'events#create'
end
