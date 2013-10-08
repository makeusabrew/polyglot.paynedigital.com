class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :url
      t.text :introduction
      t.text :content
      t.datetime :published
      t.string :status
      t.string :tags
      t.text :head_block
      t.text :script_block
      t.boolean :comments_enabled

      t.timestamps
    end
  end
end
