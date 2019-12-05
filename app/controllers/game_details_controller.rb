class GameDetailsController < ApplicationController

    def index
        game_details = GameDetail.all

        render json: GameDetailsSerializer.new(game_details).to_serialized_json
    end

end