class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :url
      t.string :original_url
      t.string :cid
      t.string :source
      t.references :post

      t.timestamps
    end
    add_index :contents, :post_id
  end
end
