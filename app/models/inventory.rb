# Model for Inventory
class Inventory < ApplicationRecord
  belongs_to :distribution_center
  belongs_to :stock_keeping_unit

  validates :quantity_available, :quantity_reserved,
            :quantity_shipped, numericality: { greater_than_or_equal_to: 0 }
  validates :distribution_center_id, :stock_keeping_unit_id, presence: true
  validates :distribution_center_id, uniqueness: { scope: [:stock_keeping_unit_id] }
  validates :stock_keeping_unit_id, uniqueness: { scope: [:distribution_center_id] }
end
