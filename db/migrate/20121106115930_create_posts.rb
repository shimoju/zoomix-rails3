class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :uid
      t.string :name
      t.string :text
      t.datetime :posted_at
      t.string :source
      t.string :postid

      t.timestamps
    end

    add_index :posts, [:postid, :source], unique: true
  end
end
