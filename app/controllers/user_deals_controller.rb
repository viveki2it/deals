class UserDealsController < ApplicationController

  def index
    @cart = current_cart
    @user_deals = current_cart.user_deals
  end

  def destroy
    user_deal = UserDeal.where("user_id = #{current_user.id} AND id = #{params[:id]}").first
    if user_deal and user_deal.destroy
      flash[:notice] = "Deal has been removed from the cart"
    else
      flash[:error] = "Removing deal from cart failed"
    end
    redirect_to user_deals_path
  end

  def expire_cart
    inactive_carts = Cart.where(["user_id = #{current_user.id} AND purchased_at IS NULL AND created_at < '#{(Time.zone.now-CART_EXPIRE_MINS).strftime('%Y-%m-%d %H:%M:00')}'"])
    inactive_carts.map{|inactive_cart| inactive_cart.destroy}
    flash[:notice] = "Your cart has been expired. Please purchase deals before your cart expires"
    redirect_to user_deals_path
  end
end
