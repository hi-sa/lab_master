class CreateFbUsers < ActiveRecord::Migration
  def change
    create_table :fb_users do |t|
      t.integer :fb_id, :limit => 8
      t.string :fb_name, :limit => 40
      t.string :name, :limit => 40
      t.string :image
      t.string :email, :limit => 30
      t.string :token
      t.integer :expires_at
      t.string :expires_at_to_dt, :limit => 25

      t.timestamps
    end
  end
end
