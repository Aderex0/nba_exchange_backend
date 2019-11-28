class TeamsController < ApplicationController
  
  def index
    teams = Team.all

    render json: teams
  end

  def show
    team = Team.find_by(teamId: params[:id])

    render json: team
  end

  def show_team_players
    team = Team.find_by(teamId: params[:id])
    team_players = team.players
  
    render json: team_players
  end

end
