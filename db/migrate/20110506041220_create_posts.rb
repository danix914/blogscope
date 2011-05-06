class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.boolean :is_public, :default => false
      t.string :name
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
