# Model for Inventory
class Inventory < ApplicationRecord
  belongs_to :distribution_center
  belongs_to :stock_keeping_unit

  validates :quantity_available, :quantity_reserved,
            :quantity_shipped, numericality: { greater_than_or_equal_to: 0 }
end
