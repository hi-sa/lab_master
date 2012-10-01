module ApplicationHelper

  #def current_user
  #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  #end

  def hbr(str)
    str = html_escape(str)
    str.gsub(/\r\n|\r|\n/, "<br />")
  end

end
