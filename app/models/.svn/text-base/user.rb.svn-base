class User < ActiveRecord::Base
  has_many :user_tokens
  has_many :user_shared_deals, :dependent => :destroy
  has_many :user_deals,:dependent => :destroy
  has_many :orders,:dependent => :destroy
  has_many :user_purchased_deals,:dependent => :destroy
  has_many :carts,:dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable



  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation, :remember_me

  validates :username,   :presence   => true,
    :uniqueness => true,
    :length => { :minimum => 3, :maximum => 40 }, :if => :password_required?

  after_create :send_welcome_email

  def send_welcome_email
      UserMailer.welcome_email(self).deliver
   end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end
  
  def apply_omniauth(omniauth)
    #add some info about the user
    #self.name = omniauth['user_info']['name'] if name.blank?
    #self.nickname = omniauth['user_info']['nickname'] if nickname.blank?
    
    unless omniauth['credentials'].blank?
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
      #user_tokens.build(:provider => omniauth['provider'], 
      #                  :uid => omniauth['uid'],
      #                  :token => omniauth['credentials']['token'], 
      #                  :secret => omniauth['credentials']['secret'])
    else
      user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    end
    #self.confirm!# unless user.email.blank?
  end
  
  def password_required?
    (user_tokens.empty? || !password.blank?) && super  
  end
end
