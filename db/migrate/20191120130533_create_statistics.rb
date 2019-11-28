class CreateStatistics < ActiveRecord::Migration[6.0]
  def change
    create_table :statistics do |t|
      t.integer :gameId
      t.integer :teamId
      t.integer :playerId
      t.integer :points
      t.string :pos
      t.string :min
      t.integer :fgm
      t.integer :fga
      t.float :fgp
      t.integer :ftm
      t.integer :fta
      t.float :ftp
      t.integer :tpm
      t.integer :tpa
      t.float :tpp
      t.integer :offReb
      t.integer :defReb
      t.integer :totReb
      t.integer :assists
      t.integer :pFouls
      t.integer :steals
      t.integer :turnovers
      t.integer :blocks
      t.integer :plusMinus
      t.float :per

      t.timestamps
    end
  end
end
