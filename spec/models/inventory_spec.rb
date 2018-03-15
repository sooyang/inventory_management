require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it { should belong_to(:distribution_center) }
  it { should belong_to(:stock_keeping_unit) }
  it { should validate_numericality_of(:quantity_available).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:quantity_shipped).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:quantity_reserved).is_greater_than_or_equal_to(0) }
end
