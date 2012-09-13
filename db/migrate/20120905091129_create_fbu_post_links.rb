class CreateFbuPostLinks < ActiveRecord::Migration
  def change
    create_table :fbu_post_links do |t|
      t.integer :fbu_base_post_id
      t.string :link
      t.text :message
      t.string :story
      t.string :picture
      t.text :caption
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
