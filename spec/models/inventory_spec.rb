require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it { should belong_to(:distribution_center) }
  it { should belong_to(:stock_keeping_unit) }
  it {
    should validate_numericality_of(:quantity_available)
      .is_greater_than_or_equal_to(0)
  }
  it {
    should validate_numericality_of(:quantity_shipped)
      .is_greater_than_or_equal_to(0)
  }
  it {
    should validate_numericality_of(:quantity_reserved)
      .is_greater_than_or_equal_to(0)
  }
  it { should validate_presence_of(:distribution_center_id) }
  it { should validate_presence_of(:stock_keeping_unit_id) }
  it do
   create(:inventory)
   should validate_uniqueness_of(:distribution_center_id).scoped_to(:stock_keeping_unit_id)
  end
  it do
   create(:inventory)
   should validate_uniqueness_of(:stock_keeping_unit_id).scoped_to(:distribution_center_id)
  end
end
