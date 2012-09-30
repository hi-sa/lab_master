# -*- coding: utf-8 -*-
class FbuPostComment < ActiveRecord::Base
  attr_accessible :id, :fbu_base_post_id, :post_id, :comment_id, :fb_id, :message, :created_time

  belongs_to :fbu_base_post


end
