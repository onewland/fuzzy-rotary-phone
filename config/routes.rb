Rails.application.routes.draw do
  post '/ping' => 'ping#show'
  get '/ping' => 'ping#show'

  post '/challenges/accept' => 'challenges#accept'

  get '/board' => 'board#show'
  post '/board/move' => 'board#move'

  post '/ttt/ingest' => 'ttt#ingest'
end
