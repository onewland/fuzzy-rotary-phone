Rails.application.routes.draw do
  post '/ping' => 'ping#show'
  get '/ping' => 'ping#show'

  post '/challenges' => 'challenges#create'
  post '/challenges/accept' => 'challenges#accept'

  get '/board' => 'board#show'
  post '/board/move' => 'board#move'
end
