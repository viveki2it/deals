class UserSharedDeal < ActiveRecord::Base
  belongs_to :deal
  belongs_to :user
  
  validates :email, :presence => true, :email_format => true
  validates :name, :presence => {:if => Proc.new{|usd| usd.user_id.nil?}}

  #validates :your_email,  :email_format => true,:presence => true

  attr_accessor :name,:your_email

  after_create :send_email

  def send_email
    UserMailer.send_deal_to_friend(self.deal, self).deliver
#    self.user.update_attribute(:credits, (self.user.credits.to_i+DEAL_SHARE_CREDITS)) if self.user and UserSharedDeal.where(["user_id = ? AND email = ?", self.user_id, self.email]).count
  end
end
