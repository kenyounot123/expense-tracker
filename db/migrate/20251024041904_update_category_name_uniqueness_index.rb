class UpdateCategoryNameUniquenessIndex < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    # Remove the global unique index on name
    remove_index :categories, :name, if_exists: true, algorithm: :concurrent

    # Add a composite unique index on name scoped to user_id
    add_index :categories, [ :user_id, :name ], unique: true, algorithm: :concurrent
  end
end
