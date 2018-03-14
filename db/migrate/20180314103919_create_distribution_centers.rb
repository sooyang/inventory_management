# Migration for creating DistributionCenter
class CreateDistributionCenters < ActiveRecord::Migration[5.1]
  def change
    create_table :distribution_centers do |t|
      t.string :country

      t.timestamps
    end
  end
end
