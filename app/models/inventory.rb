# Model for Inventory
class Inventory < ApplicationRecord
  belongs_to :distribution_center
  belongs_to :stock_keeping_unit
end
