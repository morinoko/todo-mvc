class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user
  
  def authentification_required
    if !logged_in?
      redirect_to login_path
    end
  end
  
  def logged_in?
    session[:user_id]
  end
  
  def current_user
    # the ||= method keeps the #current_user method from hitting database everytime
    @current_user ||= User.find(session[:user_id])
  end
end
