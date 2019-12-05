require 'unirest'

class Standing < ApplicationRecord
    belongs_to :team, optional: true, foreign_key: "teamId"

    def self.create_or_update_standings
        standings = Standing.get_standings_from_api

        standings.body["api"]["standings"].each do |team|
            found_team = Standing.find_by(teamId: team["teamId"])
            database_team = Team.find_by(teamId: team["teamId"])
            # byebug
            if found_team
                found_team.update(
                    teamId: team["teamId"].to_i,
                    win: team["win"].to_i,
                    loss: team["loss"].to_i,
                    conference: team["conference"]["name"],
                    rank: team["conference"]["rank"].to_i,
                    winP: team["winPercentage"].to_f,
                    lossP: team["lossPercentage"].to_f,
                    winStreak: team["winStreak"].to_i,
                    gamesPlayed: (team["win"].to_i + team["loss"].to_i),
                    shortName: database_team.shortName,
                    teamName: database_team.nickname,
                    teamLogo: database_team.logo
                )
            else
                Standing.create(
                    teamId: team["teamId"].to_i,
                    win: team["win"].to_i,
                    loss: team["loss"].to_i,
                    conference: team["conference"]["name"],
                    rank: team["conference"]["rank"].to_i,
                    winP: team["winPercentage"].to_f,
                    lossP: team["lossPercentage"].to_f,
                    winStreak: team["winStreak"].to_i,
                    gamesPlayed: (team["win"].to_i + team["loss"].to_i),
                )
            end
        end
    end

    def self.get_standings_from_api
        response = Unirest.get "https://api-nba-v1.p.rapidapi.com/standings/standard/2019",
            headers:{
                "X-RapidAPI-Host" => "api-nba-v1.p.rapidapi.com",
                "X-RapidAPI-Key" => "643c94eea2msh53636626512870fp1c3810jsnfef21a3c2700"
        }
    end
end
