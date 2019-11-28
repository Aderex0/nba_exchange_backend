require 'unirest'

class Team < ApplicationRecord
    has_many :players, primary_key: "teamId", foreign_key: "teamId"

    #Only to be ran in news of NBA team changes
    def self.create_update_or_delete_team
        self.get_nba_teams.each do |team|
            found_team = Team.find_by(teamId: team["teamId"])
            if found_team
                found_team.update(
                    city: team["city"],
                    fullName: team["fullName"],
                    logo: team["logo"],
                    nickname: team["nickname"],
                    shortName: team["shortName"],
                    confName: team["leagues"]["standard"]["confName"],
                    divName: team["leagues"]["standard"]["divName"],
                    teamId: team["teamId"].to_i,
                    nbaFranchise: team["nbaFranchise"].to_i
                )
            else
                Team.create(
                    city: team["city"],
                    fullName: team["fullName"],
                    logo: team["logo"],
                    nickname: team["nickname"],
                    shortName: team["shortName"],
                    confName: team["leagues"]["standard"]["confName"],
                    divName: team["leagues"]["standard"]["divName"],
                    teamId: team["teamId"].to_i,
                    nbaFranchise: team["nbaFranchise"].to_i
                )
            end
        end
    end


    def self.get_nba_teams
        teams = []

        self.fetch_teams.body["api"]["teams"].each do |team|
            team.each do |key, value|
                if key === "nbaFranchise" && value === "1"
                    teams.push(team)
                end
            end
        end
        return teams
    end    
    
    
    def self.fetch_teams
        
        response = Unirest.get "https://api-nba-v1.p.rapidapi.com/teams/league/standard",
            headers: {
                "X-RapidAPI-Host" => "api-nba-v1.p.rapidapi.com",
                "X-RapidAPI-Key" => "643c94eea2msh53636626512870fp1c3810jsnfef21a3c2700"
        }

    end

end
