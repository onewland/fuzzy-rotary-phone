Rails.application.routes.draw do
  # Debug routes
  # post '/ping' => 'ping#show'
  # get '/ping' => 'ping#show'

  post '/ttt/ingest' => 'ttt#ingest'
end
