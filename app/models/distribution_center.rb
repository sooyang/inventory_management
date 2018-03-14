# Model for DistributionCenter
class DistributionCenter < ApplicationRecord
  validates_presence_of :country
  validates :country, uniqueness: true
end
