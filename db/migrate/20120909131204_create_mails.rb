class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string :org_id, :limit =>30 
      t.string :subject, :limit =>200 
      t.string :sender, :limit =>60 
      t.string :to, :limit =>60 
      t.text :body
      t.datetime :send_at
      t.boolean :attach_flg

      t.timestamps
    end
    add_index :mails, [:org_id], :unique => true
  end
end
