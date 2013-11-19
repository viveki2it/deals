
require 'rubygems'
require 'open-uri'

class Deal < ActiveRecord::Base
  mount_uploader :store_image, StoreImageUploader
  attr_accessor :image_url
  validates :title ,:presence => true
  validates :deal_type_id ,:presence => { :message => "Select deal type" }
  validates :expire_date,:presence => { :message => "should be greater than today" }
  validates :coupon_expire_date ,:presence => { :message => "should be greater than today" }
  validates_numericality_of :purchase_price, :presence => { :message => "must be float"}, :only_float => true
  validates_numericality_of :credit_price, :only_float => true ,:presence => true
  validates_numericality_of :discount_price, :only_float => true
  validates :status, :presence => true, :inclusion => { :in => DEAL_STATUSES }
  validates :store_url, :store_name, :store_image, :presence => true
  #  validates :deal_date,
  #    :date => { :after => (Date.today), :message => "should be greater than today" }
  validates :expire_date,
    :date => { :after => (Date.today+1), :message => "should be greater than today" }
  validates :coupon_expire_date,
    :date => { :after => (Date.today+1), :message => "should be greater than today" }
  before_validation :download_remote_image, :if => :image_url_provided?

  validates :image_remote_url, :presence => true, :if => :image_url_provided?

  # validates :number,:presence => true
  # validates :number,:uniqueness => true

  validate :validate_unique_coupon_number
  before_create :assign_default_values

  belongs_to :deal_type
  has_many :coupons,:dependent => :destroy
  has_many :user_shared_deals,:dependent => :destroy
  has_many :active_coupons, :conditions => "status = '#{COUPON_ACTIVE}'", :class_name => "Coupon"
  has_many :images,:dependent => :destroy
  has_many :user_deals,:dependent => :destroy
  accepts_nested_attributes_for  :images,  :allow_destroy  => true,:reject_if => :all_blank
  accepts_nested_attributes_for  :coupons,  :allow_destroy  => true,:reject_if => :all_blank
  has_many :user_purchased_deals,:dependent => :destroy

  define_index do
    indexes title
    indexes store_message
    indexes description
    indexes store_name
    has status
    has deal_date, expire_date

  end

  # Require all steps to be a unique number
  def validate_unique_coupon_number
    coupon_numbers = []
    coupons.each do |coupon|
      #puts step.description
      if coupon.number.to_s.blank? or coupon_numbers.include?(coupon.number)
        errors.add(:coupons, "Coupon numbers should be mandatory and uniq for the deal")
      else
        coupon_numbers << coupon.number
      end
    end
  end

  def to_param
    "#{self.id}-#{self.store_name.to_s.parameterize}"
  end

  def is_available?
    return self.active_coupons.count > 0
  end

  def get_coupon_number
    a_coupon = self.active_coupons.first
    a_coupon.update_attributes(:status => COUPON_PENDING) if a_coupon
    return a_coupon ? a_coupon.number : nil
  end

  def credit_discount_percent
    discount_p = ""
    if credit_price.to_f > 0
      discount_p = "#{(((credit_price.to_f - purchase_price.to_f)/credit_price.to_f)*100).to_i}%"
    end
    return discount_p
  end
  
  def total_discount_percent
    discount_p = ""
    if discount_price.to_f > 0
      discount_p = "#{((((credit_price.to_f-purchase_price.to_f)+discount_price.to_f)/credit_price.to_f)*100).to_i}%"
    end
    return discount_p
  end

  def assign_default_values
    self.discount_price = 0
  end

  private

  def image_url_provided?
    !self.image_url.blank?
  end

  def download_remote_image
    self.image_url = do_download_remote_image
    self.image_remote_url = image_url
  end

  def do_download_remote_image
    io = open(URI.parse(image_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

end


