class CreateInventories < ActiveRecord::Migration[5.1]
  def change
    create_table :inventories do |t|
      t.references :distribution_center, index: true, foreign_key: true
      t.references :stock_keeping_unit, index: true, foreign_key: true
      t.integer :quantity_reserved
      t.integer :quantity_shipped
      t.integer :quantity_available

      t.timestamps
    end
  end
end
