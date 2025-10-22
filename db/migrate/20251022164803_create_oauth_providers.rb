class CreateOauthProviders < ActiveRecord::Migration[8.0]
  def change
    create_table :oauth_providers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider, null: false
      t.string :uid, null: false
      t.text :refresh_token
      t.text :access_token
      t.datetime :expires_at

      t.timestamps
    end

    add_index :oauth_providers, [ :provider, :uid ], unique: true
  end
end
