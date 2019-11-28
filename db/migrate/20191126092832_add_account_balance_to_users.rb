class AddAccountBalanceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :account_balance, :float
  end
end
