class PlayersController < ApplicationController
  def index
    players = Player.filter_players_and_add_new_players

    render json: players
    # PlayerSerializer.new(players).to_serialized_json
  end

  def show
    player = Player.find_by(playerId: params[:id])

    render json: PlayerSerializer.new(player).to_serialized_json
  end

  def show_player_statistics
    player = Player.find_by(playerId: params[:id])
    player_statistics = player.statistics

    render json: player_statistics
  end

  def show_player_averages

  end
end
