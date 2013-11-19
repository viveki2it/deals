class DealType < ActiveRecord::Base
  validates :name,:presence=>true
  has_many :deals,:dependent => :destroy
end
