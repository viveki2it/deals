class HomeController < ApplicationController
  
  # Skip the user loggin to access
  skip_before_filter :authenticate_user!

  def gmtoffset
    gmtoffset = -params[:gmtoffset].to_i*60 if !params[:gmtoffset].nil? # notice that the javascript version of gmtoffset is in minutes ;-)
    result = ActiveSupport::TimeZone.all.select{|t|t.utc_offset == gmtoffset}.first
    session[:gmtoffset] = result.name
    render :nothing => true
  end

end
