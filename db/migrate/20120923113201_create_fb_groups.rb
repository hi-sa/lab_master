class CreateFbGroups < ActiveRecord::Migration
  def change
    create_table :fb_groups do |t|
      t.column :user_id, 'integer unsigned'
      t.column :group_id, 'integer unsigned'
      t.string :name, :limit =>30
      t.string :icon, :limit =>150

      t.timestamps
    end
    add_index :fb_groups, [:group_id], :unique => true
  end
end
