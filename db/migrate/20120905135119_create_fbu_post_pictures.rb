class CreateFbuPostPictures < ActiveRecord::Migration
  def change
    create_table :fbu_post_pictures do |t|
      t.integer :fbu_base_post_id
      t.string :picture
      t.string :link
      t.text :message
      t.string :story
      t.text :caption
      t.integer :object_id, :limit=>8
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
