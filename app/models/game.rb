require 'unirest'
require 'byebug'

class Game < ApplicationRecord
    belongs_to :game_details, optional: true, foreign_key: 'gameId', primary_key: "gameId"
    has_many :statistics, primary_key: "gameId", foreign_key: "gameId"

    #Create new game entries into the database
    def self.create_game
        self.get_season_games.each do |game|
            new_game = Game.new(
                gameId: game["gameId"].to_i,
                statusShortGame: game["statusShortGame"].to_i,
                statusGame: game["statusGame"],
                vTeamId: game["vTeam"]["teamId"].to_i,
                vTeamShortName: game["vTeam"]["shortName"],
                hTeamId: game["hTeam"]["teamId"].to_i,
                hTeamShortName: game["hTeam"]["shortName"],
                startTime: game["startTimeUTC"]
            )
            if new_game
                new_game.save
            else
                byebug
                new_game.error
            end
        end
    end

    # TO BE RAN DAILY ## SINGLE API CALL ## Updates game status after finished.
    def self.update_game
        self.get_season_games.each do |game|
            game_to_update = Game.find_by(gameId: game["gameId"])

            if game_to_update
                game_to_update.update(
                    gameId: game["gameId"].to_i,
                    statusShortGame: game["statusShortGame"].to_i,
                    statusGame: game["statusGame"],
                    vTeamId: game["vTeam"]["teamId"].to_i,
                    vTeamShortName: game["vTeam"]["shortName"],
                    hTeamId: game["hTeam"]["teamId"].to_i,
                    hTeamShortName: game["hTeam"]["shortName"],
                    startTime: game["startTimeUTC"]
                )
            end
        end
    end

    #Parse information to get only regular season games
    def self.get_season_games
        games = []

        self.fetch_games.body["api"]["games"].each do |game|
            if game["seasonStage"].to_i === 2
                games.push(game)
            end
        end
        return games
    end

    #Fetching ALL the games
    def self.fetch_games


        response = Unirest.get "https://api-nba-v1.p.rapidapi.com/games/league/standard/2019",
            headers: {
                "X-RapidAPI-Host" => "Key",
                "X-RapidAPI-Key" => "Key"
        }
        
    end
end
