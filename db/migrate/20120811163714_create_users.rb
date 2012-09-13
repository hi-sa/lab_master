class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :twitter_id
      t.string :name, :limit=>50
      t.string :screen_name, :limit=>15
      t.string :image_url
      t.text :description
      t.string :access_token
      t.string :access_token_secret
      
      t.timestamps
    end
    add_index :users, [:twitter_id], :unique => true
  end
end
