class AddColumnBlogs < ActiveRecord::Migration
  def up
    add_column :blogs, :registered_blog_id, :integer
  end

  def down
    remove_column :blogs, :registered_blog_id, :integer
  end
end
