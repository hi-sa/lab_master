class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :mail_id
      t.string :file_id, :limit=>30
      t.string :filename, :limit=>100
      t.string :ext, :limit=>10
      t.string :mime_type, :limit=>30
      t.timestamps
    end
    add_index :attachments, [:file_id], :unique => true
  end
end
