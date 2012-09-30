# -*- coding: utf-8 -*-
class FbuPostLike < ActiveRecord::Base
  attr_accessible :id, :fbu_base_post_id, :post_id, :fb_id, :created_at, :updated_at

  belongs_to :fbu_base_post

end
