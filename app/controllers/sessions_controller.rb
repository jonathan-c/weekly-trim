class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    if User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      session[:user_id] = user.id
      session[:group_id], session[:auto_join] = params[:group_id], params[:auto_join]
      redirect_to pages_dispatcher_path
    else
      user = User.create_with_omniauth(auth)
      session[:user_id] = user.id
      session[:group_id], session[:auto_join] = params[:group_id], params[:auto_join]
      redirect_to pages_ask_for_email_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
