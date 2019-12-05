class AddTeamLogoToStandings < ActiveRecord::Migration[6.0]
  def change
    add_column :standings, :teamLogo, :string
  end
end
