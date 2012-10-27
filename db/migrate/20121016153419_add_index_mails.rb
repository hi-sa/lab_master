class AddIndexMails < ActiveRecord::Migration
  def up
    add_index :mails, [:send_at, :sender]
  end

  def down
    remove_index :mails, [:send_at, :sender]
  end
end
