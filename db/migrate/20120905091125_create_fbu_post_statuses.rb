class CreateFbuPostStatuses < ActiveRecord::Migration
  def change
    create_table :fbu_post_statuses do |t|
      t.integer :fbu_base_post_id
      t.text :message
      t.string :story

      t.timestamps
    end
  end
end
