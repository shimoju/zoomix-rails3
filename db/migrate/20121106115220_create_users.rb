class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.binary :access_token
      t.binary :access_token_secret
      t.binary :salt

      t.timestamps
    end
  end
end
