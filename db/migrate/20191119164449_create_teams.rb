class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :city
      t.string :fullName
      t.string :logo
      t.string :nickname
      t.string :shortName
      t.string :confName
      t.string :divName

      t.timestamps
    end
  end
end
