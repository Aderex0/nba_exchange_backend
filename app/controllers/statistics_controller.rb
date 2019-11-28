class StatisticsController < ApplicationController

    def index
        statistics = Statistic.all
    
        render json: statistics
    end
end
