# -*- coding: utf-8 -*-
class FbuPostPicture < ActiveRecord::Base

  attr_accessible :id, :fbu_base_post_id, :picture, :link, :message, :story, :caption, :object_id, :name, :desc

  belongs_to :fbu_base_post


end
