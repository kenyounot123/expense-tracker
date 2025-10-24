class UpdateCategoryNameUniquenessIndex < ActiveRecord::Migration[8.0]
  def change
    # Remove the global unique index on name
    remove_index :categories, :name, if_exists: true

    # Add a composite unique index on name scoped to user_id
    add_index :categories, [ :user_id, :name ], unique: true
  end
end
