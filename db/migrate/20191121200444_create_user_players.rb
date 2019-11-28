class CreateUserPlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :user_players do |t|
      t.integer :user_id
      t.integer :playerId
      t.integer :qtyOwned

      t.timestamps
    end
  end
end
