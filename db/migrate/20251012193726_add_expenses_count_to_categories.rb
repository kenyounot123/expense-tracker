class AddExpensesCountToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :expenses_count, :integer, default: 0, null: false
  end
end
