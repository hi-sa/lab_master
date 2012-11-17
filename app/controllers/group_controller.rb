# -*- coding: utf-8 -*-
class GroupController < ApplicationController

  layout "twitter"


  def index
    @groups = Group.all
    #@group_memebres = GroupMember.all
  end

  def new
    @groups = Group.all
    @group = Group.new
  end

  def create
  end

  def edit
    @groups = Group.all
  end

  def update
  end

  def destroy
  end

end
