class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :original_url
      t.references :post

      t.timestamps
    end
    add_index :urls, :post_id
  end
end
