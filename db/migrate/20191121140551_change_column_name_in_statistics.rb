class ChangeColumnNameInStatistics < ActiveRecord::Migration[6.0]
  def change
    rename_column :statistics, :min, :mins
  end
end
