class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      #t.integer :user_id
      t.references :user
      t.string :name,:limit =>30
      t.text :description
      t.boolean :main_flg
      t.timestamps
    end
  end
end
