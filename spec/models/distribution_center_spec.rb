require 'rails_helper'

RSpec.describe DistributionCenter, type: :model do
  it { should validate_presence_of(:country) }
  it { should validate_uniqueness_of(:country) }
end
