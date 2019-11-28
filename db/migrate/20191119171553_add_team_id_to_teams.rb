class AddTeamIdToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :teamId, :integer
  end
end
