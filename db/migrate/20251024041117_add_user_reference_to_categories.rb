class AddUserReferenceToCategories < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    # Add the column without index first
    add_column :categories, :user_id, :bigint, null: true

    # Add index concurrently
    add_index :categories, :user_id, algorithm: :concurrent

    # Backfill the data by assigning each category to the user from its first expense
    Category.reset_column_information
    Category.all.find_each do |category|
      expense = category.expenses.first
      if expense
        category.update_column(:user_id, expense.user_id)
      else
        # Handle categories with no expenses - delete them
        category.destroy
      end
    end

    # Add NOT NULL constraint
    change_column_null :categories, :user_id, false

    # Add foreign key without validation first, then validate separately
    add_foreign_key :categories, :users, validate: false
    validate_foreign_key :categories, :users
  end

  def down
    remove_foreign_key :categories, :users
    remove_reference :categories, :user
  end
end
