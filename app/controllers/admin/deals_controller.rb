class Admin::DealsController < Admin::AdminController


  def index
    conditions = !params[:status].to_s.blank? ? "status = '#{params[:status]}'" : ""
    @deals = Deal.paginate :conditions => [conditions], :page => params[:page], :order=>'updated_at desc', :per_page => 12
     #@deals = Deal.find(:all, :conditions => ["status = 'Active'"])
  end

  def new
    @deal = Deal.new
    4.times { @deal.images.build }
    5.times { @deal.coupons.build }
  end

  def create
    @deal = Deal.new(params[:deal])
    unless params[:image_urls].to_a.empty?
      params[:image_urls].map{|image_url| @deal.images.build(:image_remote_url => image_url)}
    end
    if @deal.save
      #(1..@deal.quantity).each do |coupon_number|
      # @deal.coupons.build(:number => params[:coupon] + coupon_number.to_s).save
      #end
      flash[:notice] = "Deal is Successfully created"
      redirect_to admin_deals_path
    else
      render :action => 'new'
      flash[:error] = "Deal Creation is Failed"
    end
    
  end

  def show
    @deals = Deal.all
    @deal = Deal.find(params[:id])
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def update
    @deal = Deal.find(params[:id])
    #if @deal.discount_price < @deal.purchase_price.to_i
    if @deal.update_attributes(params[:deal])
      flash[:notice] = "Deal is Successfully updated"
      redirect_to admin_deals_path
    else
      render :action => 'edit'
      flash[:error] = "Deal Updation is Failed"
    end
    #else
    #flash[:error] = 'Discount Price should be less than the purchase price'
    #render :action => 'edit'
    #end
  end

  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    redirect_to admin_deals_path
    flash[:notice] = "Successfully Deleted"
  end

end