class OrdersController < ApplicationController
  #  require 'rubygems'
  #  require 'activemerchant'
  
  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => user_deals_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end

  def new
    @order = Order.new(:express_token => params[:token])
  end

  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    @order.cart_id = current_cart.id
    @order.user_id = current_user.id
    if @order.save
      if @order.purchase and @order.purchased!
        session.delete(:cart_id)
        flash[:notice] = "Payment has been successfully done"
        redirect_to user_purchased_deals_path
      else
        
        flash[:error] = "Your payment has failed. Please try again"
        render :action => 'new'
      end
    else
      puts ">>>>>>>>>"
        puts @order.errors.inspect
      render :action => 'new'
    end
  end
end