class AddUserReferenceToCategories < ActiveRecord::Migration[8.0]
  def up
    # Add the column without index first (skip if already exists)
    unless column_exists?(:categories, :user_id)
      add_column :categories, :user_id, :bigint, null: true
    end

    # Add index (skip if already exists)
    unless index_exists?(:categories, :user_id)
      add_index :categories, :user_id
    end

    # Backfill the data by assigning each category to the user from its first expense
    Category.reset_column_information
    Category.where(user_id: nil).find_each do |category|
      expense = category.expenses.first
      if expense
        category.update_column(:user_id, expense.user_id)
      else
        # Handle categories with no expenses - delete them
        category.destroy
      end
    end

    # Add NOT NULL constraint (only if column is nullable)
    if column_exists?(:categories, :user_id) && Category.columns_hash["user_id"].null
      change_column_null :categories, :user_id, false
    end

    # Add foreign key without validation first, then validate separately (skip if already exists)
    unless foreign_key_exists?(:categories, :users)
      add_foreign_key :categories, :users, validate: false
    end
  end

  def down
    remove_foreign_key :categories, :users
    remove_reference :categories, :user
  end
end
