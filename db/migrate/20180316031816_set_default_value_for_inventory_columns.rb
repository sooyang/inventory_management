class SetDefaultValueForInventoryColumns < ActiveRecord::Migration[5.1]
  def change
    change_column_default :inventories, :quantity_reserved, 0
    change_column_default :inventories, :quantity_shipped, 0
    change_column_default :inventories, :quantity_available, 0
  end
end
