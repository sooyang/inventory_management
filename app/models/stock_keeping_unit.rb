# Model for StockKeepingUnit
class StockKeepingUnit < ApplicationRecord
  validates_presence_of :code
  validates :code, uniqueness: true
end
