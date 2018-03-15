json.id @inventory.id
json.distribution_center_id @inventory.distribution_center.id
json.stock_keeping_unit_id @inventory.stock_keeping_unit.id
json.quantity_reserved @inventory.quantity_reserved
json.quantity_shipped @inventory.quantity_shipped
json.quantity_available @inventory.quantity_available
json.created_at @inventory.created_at.to_i
json.updated_at @inventory.updated_at.to_i
