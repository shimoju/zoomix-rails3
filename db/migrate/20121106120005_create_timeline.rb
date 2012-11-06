class CreateTimeline < ActiveRecord::Migration
  def change
    create_table :timeline do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :timeline, :user_id
    add_index :timeline, :post_id
  end
end
