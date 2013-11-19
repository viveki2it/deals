class Admin::CouponsController < ApplicationController

  def create
    @deal = Deal.find(params[:deal_id])
    params[:coupon_numbers].to_a.each do |coupon_number|
      @deal.coupons.build(:number => coupon_number)
    end
    if !@deal.save
      render :update do |page|
        page.alert("Coupons creation faild. NOTE: Coupon numbers should be mandatory and uniq for this deal")
      end
    end
  end

  def edit
    @deal = Deal.find(params[:deal_id])
    @coupon = Coupon.find(params[:id])
  end

  def update
    @deal = Deal.find(params[:deal_id])
    @coupon = Coupon.find(params[:id])
    if @coupon.is_available?
      if @coupon.update_attributes(params[:coupon])
        render :update do |page|
          page << "$('#coupon_number_#{params[:id]}').html('#{@coupon.number}(#{@coupon.status})');$('#coupon_number_edit_form_#{params[:id]}').hide();$('#coupon_number_edit_#{params[:id]}').show();"
        end
      end
    else
      page.alert("This coupon has already sold. You can't updat sold coupons")
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    render :update do |page|
      if @coupon.is_available? and @coupon.destroy
        page << "$('#coupon_#{params[:id]}').html('');"
        page.alert("successfully deleted")
      else
        page.alert(@coupon.is_available? ? "deletion failed" : "This coupon has already sold. You can't delete sold coupons")
      end
    end
  end
end
