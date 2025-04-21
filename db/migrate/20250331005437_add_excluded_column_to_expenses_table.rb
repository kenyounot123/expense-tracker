class AddExcludedColumnToExpensesTable < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :excluded, :boolean, default: false
  end
end
