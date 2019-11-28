class GamesController < ApplicationController
    
    def index
        games = Game.all.order(:startTime)

        render json: games
    end

    def show
        game = Game.find_by(gameId: params[:id])
        
        render json: game
    end

end
