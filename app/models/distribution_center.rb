# Model for DistributionCenter
class DistributionCenter < ApplicationRecord
  validates_presence_of :country
  validates :country, uniqueness: true
  has_many :inventories
  has_many :stock_keeping_units, through: :inventories
end
