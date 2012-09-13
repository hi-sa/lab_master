class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :summary
      t.string :url, :limit=>200
      t.string :author, :limit=>50
      t.string :image
      t.datetime :posted_at
      t.timestamps
    end
    add_index :blogs, [:url], :unique => true
  end
end
