class CreateGameDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :game_details do |t|
      t.string :statusGame
      t.string :vTeamFullName
      t.string :vTeamLogo
      t.integer :vTeamId
      t.integer :vPoints
      t.integer :vQ1Score
      t.integer :vQ2Score
      t.integer :vQ3Score
      t.integer :vQ4Score
      t.string :hTeamFullName
      t.string :hTeamLogo
      t.integer :hTeamId
      t.integer :hPoints
      t.integer :hQ1Score
      t.integer :hQ2Score
      t.integer :hQ3Score
      t.integer :hQ4Score


      t.timestamps
    end
  end
end
