class HistoricalPricesController < ActionController::API
    
    def get_historical_price
        historical_price_data = HistoricalPrice.where(playerId: request.headers["player"].to_i)

        render json: historical_price_data
    end

    def get_price_jumps
        price_jumps = HistoricalPrice.extract_five_price_jumps

        render json: price_jumps
    end 
    
end