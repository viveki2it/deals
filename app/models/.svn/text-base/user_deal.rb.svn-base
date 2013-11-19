class UserDeal < ActiveRecord::Base
  belongs_to :deal
  belongs_to :user
  belongs_to :cart

  validates :user_id, :deal_id, :coupon_number, :cart_id ,:presence => true

  def total_price
    return (deal.purchase_price.to_f - deal.discount_price.to_f)
  end

#  before_create :set_coupon_number

  def set_coupon_number
    self.coupon_number = deal.get_coupon_number
  end

  before_destroy :make_coupon_available

  def make_coupon_available
    if !UserPurchasedDeal.exists?(:deal_id => self.deal_id, :user_id => self.user_id, :coupon_number => self.coupon_number)
      coupon = Coupon.where(["deal_id = ? AND number = ?", self.deal_id, self.coupon_number]).first
      if coupon
        coupon.update_attribute(:status, COUPON_ACTIVE) 
      end
    end
  end
end
