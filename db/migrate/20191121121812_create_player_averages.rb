class CreatePlayerAverages < ActiveRecord::Migration[6.0]
  def change
    create_table :player_averages do |t|
      t.integer :gameId
      t.integer :teamId
      t.integer :playerId
      t.float :points
      t.string :pos
      t.float :min
      t.float :fgm
      t.float :fga
      t.float :fgp
      t.float :ftm
      t.float :fta
      t.float :ftp
      t.float :tpm
      t.float :tpa
      t.float :tpp
      t.float :offReb
      t.float :defReb
      t.float :totReb
      t.float :assists
      t.float :pFouls
      t.float :steals
      t.float :turnovers
      t.float :blocks
      t.integer :plusMinus
      t.float :per

      t.timestamps
    end
  end
end
