class DealsController < ApplicationController

  # Skip the user loggin to access
  skip_before_filter :authenticate_user!, :only => [:index, :show, :share_with_friends,:search,:share]
  before_filter :get_other_deals, :only => [:index, :show]

  def index
#    @deals = Deal.paginate :conditions => ["status = '#{DEAL_FEATURED}' AND deal_date <= '#{Date.today.strftime("%Y-%m-%d")}' AND expire_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'"], :order=>'expire_date DESC', :page=>params[:page], :per_page => 12
    #:conditions => ["status = '#{DEAL_FEATURED}' AND deal_date <= '#{Date.today.strftime("%Y-%m-%d")}' AND expire_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'"], :order=>'expire_date DESC',:per_page => 12
    @deal = Deal.where(["status = '#{DEAL_FEATURED}' AND deal_date <= '#{Date.today.strftime("%Y-%m-%d")}' AND expire_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'"]).first
    render :action => "show"
  end

  def show
    @deal = Deal.find(params[:id])
  end

  def share_with_friends
    @deal = Deal.find(params[:id])
    @share = UserSharedDeal.new
    render :partial => "share_with_friends", :layout => false
  end

  def share
    @deal = Deal.find(params[:id])
    @share = UserSharedDeal.new(params[:user_shared_deal])
    if current_user
      @share = UserSharedDeal.new(params[:user_shared_deal].merge({:user_id => current_user.id, :deal_id => @deal.id}))
      if @share.save
        render :update do |page|
          page.call "hide_popup"
          page.alert("Shared successfully")
        end
      end
    else
      if @share.valid?
        render :update do |page|
          UserMailer.send_deal_to_friend(@deal, @share).deliver
          page.call "hide_popup"
          page.alert("Shared successfully")
        end
      end
    end
  end

  def purchage
    deal = Deal.find(params[:id])
    if current_user.credits >= deal.purchase_credits and coupon_number = deal.get_coupon_number
      user_purchased_deal = UserPurchasedDeal.new(:user_id => current_user.id, :deal_id => deal.id, :coupon_number => coupon_number, :purchased_type => "credits")
      if user_purchased_deal.save and current_user.update_attribute(:credits, (current_user.credits-deal.purchase_credits))
        flash[:notice] = "You have successfully purchased this deal and the coupon number is #{coupon_number}. We also sent an email with deal details and store details along with coupon number."
      else
        flash[:error] = "Purchage failed. Please try again"
      end
    else
      flash[:error] = "You do not have enough credits or deal has closed"
    end
    redirect_to deal_path(deal)
  end

  def add_to_cart
    @cart = current_cart(true)
    deal = Deal.find(params[:id])
    if deal.expire_date > Time.now and deal.is_available?
      @user_deal = UserDeal.new(:cart_id => @cart.id, :user_id => current_user.id, :deal_id => params[:id], :coupon_number => deal.get_coupon_number)
      if @user_deal.save
        message = "Successfully added to your cart"
      else
        message = "Error. Please try again"
      end
    else
      message = "Deal has already Closed/Expired. Please select another deal"
    end
    render :update do |page|
      page.alert(message)
      page << "$('#user_cart').html('Your Cart(#{current_cart.user_deals.count})')"
      page. << "GetCartTimeCount('#{ (current_cart.created_at+(CART_EXPIRE_MINS)).strftime('%Y-%m-%d %H:%M:00') }', '#{Time.now.strftime('%Y-%m-%d %H:%M:00')}', 'cart_expire_time')"
    end
  end

  def search
    @deals = Deal.search "*#{params[:query]}*", :with => {:status => [DEAL_ACTIVE, DEAL_FEATURED]}, :page => params[:page], :per_page => 10#:conditions =>["deal_date > ? AND expire_date > ?", Date.today, Time.now], :page => params[:page], :per_page => params[:per_page]
    render :action => "index"
  end

  def get_other_deals
    @active_deals = Deal.where(["status = '#{DEAL_ACTIVE}' AND deal_date <= '#{Date.today.strftime("%Y-%m-%d")}' AND expire_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'"]).order("expire_date DESC").limit(9)
  end
end
