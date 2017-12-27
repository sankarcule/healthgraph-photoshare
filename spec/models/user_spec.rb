require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:email) }
  it { should have_many(:posts) }
  it { should have_many(:primary_subscriptions) }
  it { should have_many(:secondary_subscriptions) }
  it { should have_many(:subscribers) }
  it { should have_many(:subscribed_tos) }
end
