class Group < ActiveRecord::Base
  attr_accessible :name, :description, :main_flg, :user_id, :id
  
  #アソシエーションの定義
  belongs_to :user
  has_many :group_members
  #has_and_belongs_to_many :group_members


  # main_groupsの取得
  def self.main_groups
    main_groups = self.find_all_by_main_flg(true)
  end

  # main_groupかどうか
  def main_group?
    self.main_flg == true
  end

end
