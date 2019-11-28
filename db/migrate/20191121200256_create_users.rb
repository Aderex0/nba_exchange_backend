class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :username
      t.string :email
      t.string :password_digest
      t.date :dob

      t.timestamps
    end
  end
end
