class AddMinColumnToStatistics < ActiveRecord::Migration[6.0]
  def change
    add_column :statistics, :min, :float
  end
end
