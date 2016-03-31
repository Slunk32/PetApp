class User < ActiveRecord::Base

  TYPE_OWNER = "Owner"
  TYPE_RENTER = "Renter"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]
  has_many :pets
  has_many :appointments

  has_attached_file :avatar, :styles => { :medium => "150x150>", :thumb => "32x32#" }, :default_url => "/images/:style/homer.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Omniauth allows our app to extract information from other API's
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.user_type = "Renter"
      user.password = Devise.friendly_token[0,20]
    end
  end
  # This allows the user to sign in with facebook
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def password_required?
    super && provider.blank?
  end
end
