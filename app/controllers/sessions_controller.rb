class SessionsController < ApplicationController
  def new
  end
  
  def create
    if omniauth_data
      if omniauth_email
        # Login with Omniauth Github
        user = User.find_by(email: omniauth_email)
  
        if user
          session[:user_id] = user.id
          redirect_to root_path
        else
          # Could also store the provider and their userID on the provider
          user = User.new(email: omniauth_email, password: SecureRandom.hex)
          user.save
          
          session[:user_id] = user.id
          redirect_to root_path
        end
      else
        flash[:alert] = "There was problem logging in with Github"
        render :new
      end
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
  
  def omniauth_email
    omniauth_data["info"]["email"]
  end
end
