class AddRememberTokenToSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :remember_token, :string
    add_index :sessions, :remember_token, unique: true
  end
end
