# -*- coding: utf-8 -*-
class GroupController < ApplicationController

  layout "twitter"

  def index
    @groups = Group.all
    #@group_memebres = GroupMember.all
  end

  private
#  def new
#    #formから入力された値を格納するオブジェクトの生成
#    @group = Group.new
#  end
#
#  def create
#    # この一行で、group..と名付けられた全ての入力値をハッシュで取得する
#    @group = Group.new(params[:group])
#    @group.attributes = {:user_id => session[:user_id]}
#
#    respond_to do |format|
#      if @group.save
#        #format.html { redirect_to(@group, :notice => 'Group was successfully created!')}
#        format.html { redirect_to(group_index_path, :notice => 'Group was successfully created!')}
#        format.xml { render :xml => @group, :status => :created, :location => @group}
#      else
#        format.html { render :action => 'new'}
#        format.xml { render :xml => @group.errors, :status => :unprocessable_enttity}
#      end
#    end
#  end
#
#  def edit
#  end
#
#  def update
#  end
#
#  def destroy
#  end
end
