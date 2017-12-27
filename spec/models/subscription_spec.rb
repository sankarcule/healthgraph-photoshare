require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { should belong_to(:subscriber) }
  it { should belong_to(:subscribing) }
  it { should validate_presence_of(:subscribed_by) }
  it { should validate_presence_of(:subscribed_to) }
end
