class UserPurchasedDeal < ActiveRecord::Base
  belongs_to :user
  belongs_to :deal

  after_create :update_coupon_status, :send_email_notification


  def update_coupon_status
    coupon = Coupon.where(:deal_id => self.deal_id, :number => self.coupon_number).first
    coupon.update_attribute(:status, COUPON_CLOSED) if coupon
    self.deal.update_attribute(:status, DEAL_CLOSED) if self.deal.active_coupons.count == 0
  end

  def send_email_notification
    UserMailer.deal_purchage_notification(self).deliver
  end

  def coupon
    return Coupon.where(["deal_id = ? AND number = ?", self.deal_id, self.coupon_number])
  end

end
