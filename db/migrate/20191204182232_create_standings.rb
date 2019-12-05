class CreateStandings < ActiveRecord::Migration[6.0]
  def change
    create_table :standings do |t|
      t.integer :teamId
      t.integer :win
      t.integer :loss
      t.string :conference
      t.integer :rank
      t.float :winP
      t.float :lossP
      t.integer :winStreak
      t.integer :gamesPlayed

      t.timestamps
    end
  end
end
