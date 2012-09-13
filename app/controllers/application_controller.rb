class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :fb_current_user, :fb_logged_in?

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def fb_current_user
    #@fb_current_user ||= FbUser.find(session[:fb_id]) if session[:fb_id]
    @fb_current_user ||= FbUser.find(session[:fbuser_id]) if session[:fb_id]
  end

  def logged_in?
    current_user != nil
  end

  def fb_logged_in?
    fb_current_user != nil
  end
end
