require 'rails_helper'

RSpec.describe Inventory, type: :model do
  it { should belong_to(:distribution_center) }
  it { should belong_to(:stock_keeping_unit) }
end
