class Coupon < ActiveRecord::Base
  
  validates :number ,:presence => true, :uniqueness => {:scope => :deal_id}

  belongs_to :deal

  before_create :assing_default_status

  def assing_default_status
    self.status = COUPON_ACTIVE
  end

  def is_available?
    return self.status == COUPON_ACTIVE
  end
end
