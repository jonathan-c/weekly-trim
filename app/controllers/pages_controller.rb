class PagesController < ApplicationController
  def welcome
  end
  
  def index
    render :layout=>false
  end
  
  def no_access
    
  end
end
