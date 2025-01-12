class AddFieldsToExpense < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :amount, :decimal, null: false
    add_column :expenses, :description, :string
    add_column :expenses, :category, :string
    add_column :expenses, :expense_type, :string
    add_column :expenses, :date, :date
  end
end
