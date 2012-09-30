# -*- coding: utf-8 -*-
class FbuPostVideo < ActiveRecord::Base

  attr_accessible :id, :fbu_base_post_id, :link, :message, :story, :picture, :source, :name,:object_id, :desc

  belongs_to :fbu_base_post
end
