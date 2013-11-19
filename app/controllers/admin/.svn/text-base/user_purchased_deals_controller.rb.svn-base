class Admin::UserPurchasedDealsController < Admin::AdminController

  def index
    @user_purchased_deals = UserPurchasedDeal.paginate(:page => params[:page], :order => 'created_at desc', :per_page => 10)
  end

  def show
    @deal = Deal.find(params[:id])
  end

  def user_deals
    @deals = Deal.paginate(:page => params[:page], :order => 'created_at desc', :per_page => 10)
  end

  def search
    @deals = Deal.search "*#{params[:query]}*", :page => params[:page], :per_page => 10#:conditions =>["deal_date > ? AND expire_date > ?", Date.today, Time.now], :page => params[:page], :per_page => params[:per_page]
    render :action => 'user_deals'
  end

end
