class UserMailer < ActionMailer::Base
  default :from => "noreply@deals.com"

  def welcome_email(user)
    @user = user
    @url  = "#{BASE_URL}/users/sign_in"
    mail(:to => user.email, :subject => "Welcome to #{SITE_NAME}")
  end

  def send_deal_to_friend(deal, user_shared_deal)
    @user_shared_deal = user_shared_deal
    @deal  = deal
    @url  = BASE_URL+deal_path(@deal)
    mail(:to => user_shared_deal.email, :subject => "Deal details of #{@deal.title}")
  end

  def deal_purchage_notification(user_purchased_deal)
    @user_purchased_deal = user_purchased_deal
    @user = user_purchased_deal.user
    @deal  = user_purchased_deal.deal
    @url  = BASE_URL+deal_path(@deal)
    mail(:to => @user.email, :subject => "You have purchased a deal: #{@deal.title}")
  end

end
