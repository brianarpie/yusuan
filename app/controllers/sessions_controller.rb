class SessionsController < ApplicationController

  def create
    # see what omniauth.auth returns after authentication
    # render text: request.env['omniauth.auth'].to_yaml
    begin
      @user = User.from_omniauth(request.env['omniauth.auth'])
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}!"
    rescue
      flash[:warning] = "There was an error while trying to authenticate you..."
    end
    redirect_to root_path
  end

  def destroy
    if current_user
      session.delte(:user_id)
      flash[:success] = 'See you later!'
    end
    redirect_to root_path
  end

  def auth_failure
    redirect_to root_path
  end

end
