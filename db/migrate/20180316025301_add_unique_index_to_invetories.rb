class AddUniqueIndexToInvetories < ActiveRecord::Migration[5.1]
  def change
    add_index :inventories, [:distribution_center_id, :stock_keeping_unit_id], unique: true, name: 'dc_sku_index'
  end
end
