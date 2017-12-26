class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: "User", foreign_key: 'subscribed_by', optional: true
  belongs_to :subscribing, class_name: "User", foreign_key: 'subscribed_to', optional: true
  validates :subscribed_to, presence: true
  validates :subscribed_by, presence: true
end
