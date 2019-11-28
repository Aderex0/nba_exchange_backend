require 'unirest'
require 'byebug'

class Statistic < ApplicationRecord
    belongs_to :game, optional: true
    belongs_to :player, optional: true

    def self.create_and_save_statistics(response)
        
        response.body["api"]["statistics"].each do |statistic|
            Statistic.create(
                gameId: statistic["gameId"].to_i,
                teamId: statistic["teamId"].to_i,
                playerId: statistic["playerId"].to_i,
                points: statistic["points"].to_i,
                pos: statistic["pos"],
                min: statistic["min"].to_f,
                fgm: statistic["fgm"].to_i,
                fga: statistic["fga"].to_i,
                fgp: statistic["fgp"].to_f,
                ftm: statistic["ftm"].to_i,
                fta: statistic["fta"].to_i,
                ftp: statistic["ftp"].to_f,
                tpm: statistic["tpm"].to_i,
                tpa: statistic["tpa"].to_i,
                tpp: statistic["tpp"].to_f,
                offReb: statistic["offReb"].to_i,
                defReb: statistic["defReb"].to_i,
                totReb: statistic["totReb"].to_i,
                assists: statistic["assists"].to_i,
                pFouls: statistic["pFouls"].to_i,
                steals: statistic["steals"].to_i,
                blocks: statistic["blocks"].to_i,
                turnovers: statistic["turnovers"].to_i,
                plusMinus: statistic["plusMinus"].to_i
            )
        end
    end

    #TO BE RAN ON DAILY BASIS AFTER THE GAME API HAS BEEN CALLED. Updates game stats.
    def self.fetch_finished_game_stats

        self.finished_games.each do |game|
            gameId = game["gameId"]

            response = Unirest.get "https://api-nba-v1.p.rapidapi.com/statistics/players/gameId/" + "#{gameId}",
                headers: {
                    "X-RapidAPI-Host" => "api-nba-v1.p.rapidapi.com",
                    "X-RapidAPI-Key" => "643c94eea2msh53636626512870fp1c3810jsnfef21a3c2700"
                }

            self.create_and_save_statistics(response)
        end
    end

    #Helper: Checks if game if finished but has no statistics
    def self.finished_games
        finished_games = []

        Game.all.each do |game|
            if game.statistics === [] && game["statusShortGame"] === 3
                finished_games.push(game)
            end
        end
        finished_games
    end
end
