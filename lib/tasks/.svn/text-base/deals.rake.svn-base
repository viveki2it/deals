namespace :deals do
  desc "Make active which are scheduled"
	task :make_active => :environment do
    deals = Deal.where(["deal_date = '#{Date.today}' AND status = '#{DEAL_SCHEDULED}'"])
    deals.each do |deal|
      deal.update_attribute(:status, DEAL_ACTIVE)
    end
	end

  desc "Make expired which are expired time"
	task :make_expired => :environment do
    deals = Deal.where(["expire_date >= '#{(Time.now.-((60*60))).strftime('%Y-%m-%d %H:00:00')}' AND expire_date <= '#{(Time.now)}'"])
    deals.each do |deal|
      deal.update_attribute(:status, DEAL_EXPIRED)
    end
	end

  #  desc "Make expires when coupon expired"
  #	task :coupon_expired => :environment do
  #    deals = Deal.where(["coupon_expire_date >= '#{(Time.now.-((60*60))).strftime('%Y-%m-%d %H:00:00')}' AND coupon_expire_date <= '#{(Time.now)}'"])
  #    deals.each do |deal|
  #      puts deal.update_attribute(:status, DEAL_EXPIRED)
  #      puts deal.errors.to_a
  #    end
  #	end

  
end


namespace :carts do
  desc "Delete inactive carts"
	task :delete_inactive => :environment do
    carts = Cart.where(["purchased_at IS NULL"])
    carts.each do |cart|
      Time.zone = cart.time_zone
      if cart.created_at < (Time.zone.now-CART_EXPIRE_MINS)
        cart.destroy
      end
    end
  end
end