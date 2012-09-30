# -*- coding: utf-8 -*-
class FbuPostStatus < ActiveRecord::Base

  attr_accessible :id, :fbu_base_post_id, :message, :story

  belongs_to :fbu_base_post
  
end
