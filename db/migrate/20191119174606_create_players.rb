class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :firstName
      t.string :lastName
      t.string :pos
      t.integer :playerId
      t.integer :teamId

      t.timestamps
    end
  end
end
