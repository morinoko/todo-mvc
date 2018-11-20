class SessionsController < ApplicationController
  def new
  end
  
  def create
    if omniauth_data
      # Login with Omniauth Github
      raise omniauth_data.inspect
      user = User.find_by(email: )
      
      # omniauth_data["info]
    else
      # Normal login with username and password
      user = User.find_by(email: params[:user][:email])
      
      if user && user.authenticate(params[:user][:password])
        session[:user_id] = user.id
        
        redirect_to root_path
      else
        render :new
      end
    end
  end
  
  def destroy
    reset_session
    redirect_to login_path
  end
  
  def omniauth_data
    request.env["omniauth.auth"]
  end
end
