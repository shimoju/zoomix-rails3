class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :access_token, :string
    add_column :users, :encrypted_access_token, :string
    add_column :users, :access_token_secret, :string
    add_column :users, :encrypted_access_token_secret, :string

    add_index :users, [:uid, :provider], unique: true
  end
end
