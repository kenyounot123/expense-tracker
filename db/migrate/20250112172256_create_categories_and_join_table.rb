class CreateCategoriesAndJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps
    end

    add_index :categories, :name, unique: true

    create_table :categories_expenses, id: false do |t|
      t.belongs_to :category
      t.belongs_to :expense
    end

    remove_column :expenses, :category
  end
end
