# Model for StockKeepingUnit
class StockKeepingUnit < ApplicationRecord
  validates_presence_of :code
  validates :code, uniqueness: true
  has_many :inventories
  has_many :distribution_centers, through: :inventories
end
