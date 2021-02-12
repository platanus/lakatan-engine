Lakatan::Engine.routes.draw do
  post '/notifications', to: 'notifications#create'
end
