class CreateBlogMembers < ActiveRecord::Migration
  def change
    create_table :blog_members do |t|
      t.integer :group_member_id
      t.integer :group_id
      t.string :blog_url
      t.string :blog_name, :limit => 50
      t.text :description

      t.timestamps
    end
  end
end
