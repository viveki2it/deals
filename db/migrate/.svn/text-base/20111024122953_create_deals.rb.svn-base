class CreateDeals < ActiveRecord::Migration
  def self.up
    create_table :deals do |t|
      t.string :title
      t.integer :deal_type_id
      t.float :purchase_price
      t.integer :purchase_credits
      t.string :status
      t.date :deal_date
      t.datetime :expire_date
      t.datetime :coupon_expire_date
      t.integer :store_id
      t.text :store_message
      t.text :description
      t.string :store_url

      t.timestamps
    end
  end

  def self.down
    drop_table :deals
  end
end
