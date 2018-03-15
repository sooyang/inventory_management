json.array! @distribution_centers do |distribution_center|
  json.distribution_center do
    json.id distribution_center.id
    json.country distribution_center.country
    json.inventories distribution_center.inventories do |inventory|
      json.id inventory.id
      json.stock_keeping_unit do
        json.id inventory.stock_keeping_unit.id
        json.code inventory.stock_keeping_unit.code
        json.created_at inventory.stock_keeping_unit.created_at.to_i
        json.updated_at inventory.stock_keeping_unit.updated_at.to_i
      end
      json.quantity_reserved inventory.quantity_reserved
      json.created_at inventory.created_at.to_i
      json.updated_at inventory.updated_at.to_i
    end
    json.created_at distribution_center.created_at.to_i
    json.updated_at distribution_center.updated_at.to_i
  end
end
