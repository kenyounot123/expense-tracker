class MigrateFromHabtmToHasManyThrough < ActiveRecord::Migration[8.0]
  def up
    # Copy data from old HABTM join table to new join table
    if table_exists?(:categories_expenses)

      execute <<-SQL
        INSERT INTO category_expenses (category_id, expense_id, created_at, updated_at)
        SELECT category_id, expense_id, datetime('now'), datetime('now')
        FROM categories_expenses
      SQL

      # Update counter cache for all categories
      Category.find_each do |category|
        Category.reset_counters(category.id, :expenses)
      end

      # Drop the old HABTM join table
      drop_table :categories_expenses
    end
  end

  def down
    # Recreate the old HABTM join table
    create_table :categories_expenses, id: false do |t|
      t.belongs_to :category, null: false
      t.belongs_to :expense, null: false
    end

    add_index :categories_expenses, [ :category_id, :expense_id ], unique: true

    # Copy data back
    execute <<-SQL
      INSERT INTO categories_expenses (category_id, expense_id)
      SELECT category_id, expense_id
      FROM category_expenses
    SQL
  end
end
