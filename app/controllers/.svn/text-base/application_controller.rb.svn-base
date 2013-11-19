class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_cart

  # This is will check for the user, if user not loggedin then will redirect to login page
  before_filter :authenticate_user!, :set_time_zone

  def set_time_zone
    Time.zone = session[:gmtoffset] if session[:gmtoffset]
  end
  

  # Will check for admin user, if user is not admin then redirect to home page 
  def is_admin?
    unless current_user.is_admin
      flash[:error] = "Permission denied"
      redirect_to "/"
    end
  end

  def current_cart(create_if_not_exist=false)
    cart = current_user ? Cart.where(["id = ? AND user_id = ? AND purchased_at IS NULL", session[:cart_id], current_user.id]).first : Cart.new
    unless cart
      if create_if_not_exist
        cart = Cart.create(:user_id => current_user.id, :time_zone => session[:gmtoffset])
        session[:cart_id] = cart.id
      else
        cart = Cart.new(:user_id => current_user.id)
      end
    end
    cart
  end

  
end
