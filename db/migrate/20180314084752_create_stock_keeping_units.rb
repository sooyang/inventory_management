# Migration for StockKeepingUnit
class CreateStockKeepingUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :stock_keeping_units do |t|
      t.string :code

      t.timestamps
    end
  end
end
