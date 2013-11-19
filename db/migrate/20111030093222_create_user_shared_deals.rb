class CreateUserSharedDeals < ActiveRecord::Migration
  def self.up
    create_table :user_shared_deals do |t|
      t.integer :user_id
      t.integer :deal_id
      t.string :email
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :user_shared_deals
  end
end
