require 'rails_helper'

RSpec.describe DistributionCenter, type: :model do
  it { should validate_presence_of(:country) }
  it { should validate_uniqueness_of(:country) }
  it { should have_many(:inventories) }
  it { should have_many(:stock_keeping_units).through(:inventories) }
end
