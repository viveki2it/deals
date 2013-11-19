class ChangePurchaseCreditsInDeals < ActiveRecord::Migration
  def self.up
    rename_column :deals, :purchase_credits, :credit_price
    change_column :deals, :credit_price, :float
  end

  def self.down
    rename_column :deals, :credit_price, :purchase_credits
  end
end
