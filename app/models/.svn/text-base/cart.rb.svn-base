class Cart < ActiveRecord::Base
  has_many :user_deals, :dependent => :destroy
  has_one :order, :dependent => :destroy

  def add_deal(deal_id)
    current_item = user_deals.where(:deal_id => deal_id).first
    if current_item
      current_item
    else
      current_item = UserDeal.new(:deal_id => deal_id)
      user_deals << current_item
    end
    current_item
  end

  def total_price
    user_deals.to_a.sum {|item| item.total_price}
  end

  def total_price_in_cents
    (self.total_price*100).round
  end

end