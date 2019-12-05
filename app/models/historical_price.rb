class HistoricalPrice < ApplicationRecord
    belongs_to :player, optional: true

    def self.create_historical_price
        players = Player.all

        players.each do |player|
            new_entry = HistoricalPrice.new(
                playerId: player.playerId,
                date: Date.today,
                buy: player.buy
            )
            new_entry.save
        end
    end

    def self.extract_five_price_jumps
        allPlayers = []
        player_price = HistoricalPrice.where("date BETWEEN ? AND ?", Date.yesterday, Date.today).pluck(:buy, :playerId)

        Player.all.each do |player|

            if player.player_average.min > 20
                price_comparison = player_price.select{|data| data[1] == player.playerId }
            
                allPlayers.push({ 
                    firstName: player.firstName, 
                    lastName: player.lastName, 
                    playerId: player.playerId, 
                    change: (price_comparison[1][0] - price_comparison[0][0]).round(2) 
                })
            end
        end

        sorted_players = []
        sorted_players.push(allPlayers.sort_by {|player| player[:change] }.last(5))
        sorted_players.push(allPlayers.sort_by {|player| player[:change] }.first(5))

        return sorted_players
    end
end
