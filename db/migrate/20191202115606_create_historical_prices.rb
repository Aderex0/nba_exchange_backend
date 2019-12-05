class CreateHistoricalPrices < ActiveRecord::Migration[6.0]
  def change
    create_table :historical_prices do |t|
      t.integer :playerId
      t.date :date
      t.float :buy

      t.timestamps
    end
  end
end
