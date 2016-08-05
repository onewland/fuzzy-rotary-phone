Rails.application.routes.draw do
  post '/ping' => 'ping#show'
  get '/ping' => 'ping#show'

  get '/board' => 'board#show'

  post '/ttt/ingest' => 'ttt#ingest'
end
