class GroupController < ApplicationController
  # GET group_index
  def index
    # ユーザーが作成したグループの取得
    @groups = Group.find_all_by_user_id(session[:user_id])
    @group_members = Group.find(1).group_members 
    @hoge = GroupMembers.find(1)
    raise @hoge
    exit
    #raise @groups.to_yaml
    #exit
  end

  def new
    #formから入力された値を格納するオブジェクトの生成
    @group = Group.new
  end

  def create
    # この一行で、group..と名付けられた全ての入力値をハッシュで取得する
    @group = Group.new(params[:group])
    @group.attributes = {:user_id => session[:user_id]}

    respond_to do |format|
      if @group.save
        #format.html { redirect_to(@group, :notice => 'Group was successfully created!')}
        format.html { redirect_to(group_index_path, :notice => 'Group was successfully created!')}
        format.xml { render :xml => @group, :status => :created, :location => @group}
      else
        format.html { render :action => 'new'}
        format.xml { render :xml => @group.errors, :status => :unprocessable_enttity}
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
