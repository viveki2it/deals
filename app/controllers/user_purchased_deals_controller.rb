class UserPurchasedDealsController < ApplicationController
  def index
    @user_purchased_deals = current_user.user_purchased_deals.paginate(:page => params[:page], :order => 'created_at desc', :per_page => 10)
  end
end
