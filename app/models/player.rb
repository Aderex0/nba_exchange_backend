require 'unirest'
require 'byebug'

class Player < ApplicationRecord
    belongs_to :team, optional: true
    belongs_to :player_average, optional: true, primary_key: "playerId", foreign_key: "playerId"
    has_many :statistics, primary_key: "playerId", foreign_key: "playerId"
    has_many :user_players
    has_many :users, through: :user_players, primary_key: "playerId", foreign_key: "playerId"
    has_many :historical_prices, primary_key: "playerId", foreign_key: "playerId"

    #filters players by minutes and any new players get a price and spread assigned

    def self.filter_players_and_add_new_players
        active_players = PlayerAverage.where.not(min: "NaN").where("min > 20").map{|player_average| player_average.player}

        active_players.each do |player|
            if player.buy <= 0.00
                if player.player_average.points < 10.0
                player.update(
                    buy: (player.player_average.points.round(0) * 0.01).round(2),
                    sell: (player.player_average.points.round(0) * 0.01 - 0.01).round(2)
                )
                elsif player.player_average.points < 20.0
                    player.update(
                        buy: (player.player_average.points.round(0) * 0.01).round(2),
                        sell: (player.player_average.points.round(0) * 0.01 - 0.02).round(2)
                    )
                elsif player.player_average.points < 30.0
                    player.update(
                        buy: (player.player_average.points.round(0) * 0.01).round(2),
                        sell: (player.player_average.points.round(0) * 0.01 - 0.03).round(2)
                    )
                else
                    player.update(
                        buy: (player.player_average.points.round(0) * 0.01).round(2),
                        sell: (player.player_average.points.round(0) * 0.01 - 0.04).round(2)
                    )
                end      
            end
        end
        
        active_players
    end

    #Creates updates or deletes player into the database
    ## SINGLE API CALL ## TO BE RAN ON DAILY BASIS ## to get new players that have been signed or waived
    def self.create_update_or_delete_player

        self.get_active_players.each do |player|
            found_player = Player.find_by(playerId: player["playerId"])

            if found_player
                found_player.update(
                    firstName: player["firstName"],
                    lastName: player["lastName"],
                    pos: player["leagues"]["standard"]["pos"],
                    playerId: player["playerId"].to_i,
                    teamId: player["teamId"].to_i
                )
            else
                Player.create(
                    firstName: player["firstName"],
                    lastName: player["lastName"],
                    pos: player["leagues"]["standard"]["pos"],
                    playerId: player["playerId"].to_i,
                    teamId: player["teamId"].to_i,
                    qtyBought: 0,
                    qtySold: 0,
                    buy: 0.00,
                    sell: 0.00
                )
            end

            if player["playerId"] === nil
                player_to_be_deleted = Player.find_by(playerId: playerId["player"])
                player_to_be_deleted.delete
            end
        end 
    end
    
    #Get only the players that are active in the NBA currently.
    def self.get_active_players
        players = []

        self.fetch_players.body["api"]["players"].each do |player|
            byebug unless player["playerId"] != "2110"
            if player["leagues"]["standard"]["active"] == "1" && player["startNba"] != "0"
                players.push(player)
            end
        end
        return players
    end

    #Fetch ALL the players from API
    def self.fetch_players
        
        response = Unirest.get "https://api-nba-v1.p.rapidapi.com/players/league/standard",
            headers: {
                "X-RapidAPI-Host" => "key",
                "X-RapidAPI-Key" => "key"
        }
    end

    private

    #help to set player values at the begining
    def self.player_value_change
        players = Player.filter_players_and_add_new_players
        
        players.each do |player|
                if player.player_average.points < 10.0
                    player.update(
                        buy: (player.player_average.points.round(0) * 0.01).round(2),
                        sell: (player.player_average.points.round(0) * 0.01 - 0.01).round(2)
                    )
                elsif player.player_average.points < 20.0
                        player.update(
                            buy: (player.player_average.points.round(0) * 0.01).round(2),
                            sell: (player.player_average.points.round(0) * 0.01 - 0.02).round(2)
                        )
                elsif player.player_average.points < 30.0
                        player.update(
                            buy: (player.player_average.points.round(0) * 0.01).round(2),
                            sell: (player.player_average.points.round(0) * 0.01 - 0.03).round(2)
                        )
                else
                        player.update(
                            buy: (player.player_average.points.round(0) * 0.01).round(2),
                            sell: (player.player_average.points.round(0) * 0.01 - 0.04).round(2)
                        )
                end
        end
    end
end
