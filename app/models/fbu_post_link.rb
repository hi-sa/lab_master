# -*- coding: utf-8 -*-
class FbuPostLink < ActiveRecord::Base

  attr_accessible :id, :fbu_base_post_id, :link, :message, :story, :picture, :caption, :name, :desc

  belongs_to :fbu_base_post


end
