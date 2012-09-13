class CreateGroupMembers < ActiveRecord::Migration
  def change
    create_table :group_members do |t|
      t.references :group
      t.string :name, :limit => 15
      t.integer :twitter_id
      t.integer :fb_id, :limit=>8
      t.string :blog_url

      t.timestamps
    end
  end
end
