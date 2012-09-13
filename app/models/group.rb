class Group < ActiveRecord::Base
  attr_accessible :name, :description, :main_flg, :user_id, :id
  #accepts_nested_attributes_for :group_members, :allow_destroy => true
  
  #アソシエーションの定義
  belongs_to :user
  #has_and_belongs_to_many :group_members
  has_many :group_members

end
