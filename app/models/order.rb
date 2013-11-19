class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :user
  has_many :transactions, :class_name => 'OrderTransaction'
  
  attr_accessor :card_number, :card_verification, :first_name, :last_name, :card_type, :card_expires_on, :price, :ip_address, :user_id, :address, :city, :state, :zip, :country
  validate :validate_card, :on => :create
  validates :address, :city, :state, :country, :zip, :presence => true


  def purchase
    response = process_purchase
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def express_token=(token)
    write_attribute(:express_token, token)
    if new_record? && !token.blank?
      details = EXPRESS_GATEWAY.details_for(token)
      self.express_payer_id = details.payer_id
      self.first_name = details.params["first_name"]
      self.last_name = details.params["last_name"]
    end
  end

  def price_in_cents
    (cart.total_price*100).round
  end

  def purchased!
    for user_deal in cart.user_deals
      UserPurchasedDeal.create(:user_id => user_deal.user_id, :deal_id => user_deal.deal_id, :coupon_number => user_deal.coupon_number, :purchased_type => "payment")
    end
  end

  private

  def process_purchase
    if express_token.blank?
      STANDARD_GATEWAY.purchase(price_in_cents, credit_card, standard_purchase_options)
    else
      EXPRESS_GATEWAY.purchase(price_in_cents, express_purchase_options)
    end
  end

  def standard_purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => self.first_name+" "+self.last_name,
        :address1 => self.address,
        :city     => self.city,
        :state    => self.state,
        :country  => self.country,
        :zip      => self.zip,
      }
    }
  end

  def express_purchase_options
    {
      :ip => ip_address,
      :token => express_token,
      :payer_id => express_payer_id
    }
  end

  def validate_card
    if express_token.blank? && !credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add(:base, message)
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end

end
