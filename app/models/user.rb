class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates_format_of :email, with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "incorrect email format"

  def self.from_omniauth(auth)
  identity = Identity.where(provider: auth.provider, uid: auth.uid)
  if identity.present?
    return identity.first.user
  else
    user = User.where(email: auth.info.email)
    if user.present?
      Identity.create(provider: auth.provider, uid: auth.uid, user_id: user.first.id)
      return user.first
    else
      user = User.create(email: auth.info.email, password: Devise.friendly_token[0,20])
      Identity.create(provider: auth.provider, uid: auth.uid, user_id: user.id)
      return user
    end
  end
end

end
