class CreateTwMembers < ActiveRecord::Migration
  def change
    create_table :tw_members do |t|
      t.integer :group_member_id
      t.integer :group_id
      t.integer :twitter_id
      t.string :name, :limit => 50
      t.string :screen_name, :limit => 15
      t.string :image_url
      t.text :description

      t.timestamps
    end
    add_index :tw_members, [:group_member_id], :unique => true
    add_index :tw_members, [:twitter_id], :unique => true
  end
end
