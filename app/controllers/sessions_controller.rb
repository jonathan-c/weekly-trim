class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    if params[:group_id].present?
      if params[:auto_join].present?
        session[:auto_join] = params[:auto_join]
        redirect_to group_path(params[:group_id])
      else
        redirect_to group_path(params[:group_id])
      end
    else
      redirect_to welcome_path, notice: "Signed in!"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end
