Rails.application.routes.draw do
  post '/ping' => 'ping#show'
  get '/ping' => 'ping#show'

  post '/ttt/ingest' => 'ttt#ingest'
end
