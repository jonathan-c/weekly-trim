class PagesController < ApplicationController
  
  def welcome
  end
  
  def index
    render :layout=>false
  end
  
  def no_access
    
  end
  
  def ask_for_email
    
  end
  
  def update_email
    current_user.update_attributes(email: params[:email])
    redirect_to pages_dispatcher_path
  end
  
  def dispatcher
    if session[:group_id].present?
      if session[:auto_join].present?
        redirect_to group_path(session[:group_id])
      else
        session.delete(:auto_join)
        redirect_to group_path(session[:group_id])
      end
    else
      session.delete(:auto_join)
      redirect_to welcome_path, notice: "Signed in!"
    end
  end
  

end
