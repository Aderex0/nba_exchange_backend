class AddNbaFranchiseToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :nbaFranchise, :integer
  end
end
