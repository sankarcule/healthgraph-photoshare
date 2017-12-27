class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  validates_format_of :email, with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "incorrect email format"

  has_many :primary_subscriptions, class_name:  "Subscription",
                                  foreign_key: "subscribed_by",
                                  dependent:   :destroy
  has_many :subscribed_tos, through: :primary_subscriptions, source: :subscribing
  has_many :secondary_subscriptions, class_name:  "Subscription",
                                 foreign_key: "subscribed_to",
                                 dependent:   :destroy
  has_many :subscribers, through: :secondary_subscriptions, source: :subscriber, foreign_key: "subscribed_by"

  has_many :posts, dependent: :destroy


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

  def subscribe(subscribed_by, subscribing_id)
    Subscription.create!(subscribed_by: subscribed_by, subscribed_to: subscribing_id)
  end

  def unsubscribe(subscribed_by, subscribing_id)
    Subscription.where(subscribed_by: subscribed_by, subscribed_to: subscribing_id).destroy_all
  end

end
