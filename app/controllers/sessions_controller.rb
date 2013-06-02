class SessionsController < ApplicationController
  def  create
    debugger
    user = User.from_auth request.env['omniauth.auth'], current_user
    session[:user_id] = user.id if user

    redirect_to root_path
  end


  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end
end
