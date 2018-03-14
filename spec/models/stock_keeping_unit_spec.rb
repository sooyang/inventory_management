require 'rails_helper'

RSpec.describe StockKeepingUnit, type: :model do
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:code) }
end
