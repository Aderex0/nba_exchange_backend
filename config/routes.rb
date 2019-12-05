Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :teams, only: [:index, :show]
  get 'teams/:id/players', to: 'teams#show_team_players'

  resources :players, only: [:index, :show]
  get 'players/:id/statistics', to: 'players#show_player_statistics'

  resources :games, only: [:index, :show]
  resources :statistics, only: [:index, :show]

  resources :users, only: [:create]
  post '/login', to: 'users#login' 
  get '/validate', to: 'users#validate'

  post '/buy_player', to: 'user_players#buy_player'
  post '/sell_player', to: 'user_players#sell_player'
  get '/owned_players', to: 'user_players#get_owned_players'

  get '/get_historical_price', to: 'historical_prices#get_historical_price'
  get '/get_price_jumps', to: 'historical_prices#get_price_jumps'

  get '/standings', to: 'standings#standings_index'

  resources :game_details, only: [:index]
end
