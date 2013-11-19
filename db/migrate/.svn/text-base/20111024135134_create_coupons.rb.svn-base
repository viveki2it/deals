class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.integer :deal_id
      t.string :number, :limit => 20
      t.string :status, :limit => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
