class GameDetail < ApplicationRecord
    belongs_to :game, optional: true, foreign_key: 'gameId', primary_key: "gameId"

    def self.fetch_finished_game_details
        finished_games = self.finished_games
        finished_games.each do |game|
            gameId = game["gameId"]    

            response = Unirest.get "https://api-nba-v1.p.rapidapi.com/gameDetails/" + "#{gameId}",
                headers:{
                    "X-RapidAPI-Host" => "api-nba-v1.p.rapidapi.com",
                    "X-RapidAPI-Key" => "643c94eea2msh53636626512870fp1c3810jsnfef21a3c2700"
                }

            self.create_finished_game_details(response)
        end
    end

    def self.create_finished_game_details(response)
        
        response.body["api"]["game"].each do |game|
            new_game = GameDetail.new(
                statusGame: game["statusGame"],
                gameId: game["gameId"],
                vTeamFullName: game["vTeam"]["fullName"],
                vTeamLogo: game["vTeam"]["logo"],
                vTeamId: game["vTeam"]["teamId"],
                vPoints: game["vTeam"]["score"]["points"],
                vQ1Score: game["vTeam"]["score"]["linescore"][0],
                vQ2Score: game["vTeam"]["score"]["linescore"][1],
                vQ3Score: game["vTeam"]["score"]["linescore"][2],
                vQ4Score: game["vTeam"]["score"]["linescore"][3],
                hTeamFullName: game["hTeam"]["fullName"],
                hTeamLogo: game["hTeam"]["logo"],
                hTeamId: game["vTeam"]["teamId"],
                hPoints: game["hTeam"]["score"]["points"],
                hQ1Score: game["vTeam"]["score"]["linescore"][0],
                hQ2Score: game["vTeam"]["score"]["linescore"][1],
                hQ3Score: game["vTeam"]["score"]["linescore"][2],
                hQ4Score: game["vTeam"]["score"]["linescore"][3]
            )
            
            if new_game
                new_game.save
            end
        end
    end

    # helper method to find finished games
    def self.finished_games
        finished_games = []

        Game.all.each do |game|
            if game["statusShortGame"] === 3
                finished_games.push(game)
            end
        end
        finished_games
    end
end
