class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :access_token, :binary
    add_column :users, :access_token_secret, :binary
    add_column :users, :salt, :binary

    add_index :users, [:uid, :provider], unique: true
  end
end
