class StandingsController < ApplicationController
    def standings_index        
        standings = Standing.all

        render json: standings
    end
end
