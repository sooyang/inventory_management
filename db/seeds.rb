sku1 = StockKeepingUnit.create(code: 'SKU-00000001')
sku2 = StockKeepingUnit.create(code: 'SKU-00000002')
sku3 = StockKeepingUnit.create(code: 'SKU-00000003')

dc_sg = DistributionCenter.create(country: 'Singapore')
dc_th = DistributionCenter.create(country: 'Thailand')

Inventory.create(
  stock_keeping_unit: sku1,
  distribution_center: dc_sg,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)

Inventory.create(
  stock_keeping_unit: sku2,
  distribution_center: dc_sg,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)

Inventory.create(
  stock_keeping_unit: sku3,
  distribution_center: dc_sg,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)

Inventory.create(
  stock_keeping_unit: sku1,
  distribution_center: dc_th,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)

Inventory.create(
  stock_keeping_unit: sku2,
  distribution_center: dc_th,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)

Inventory.create(
  stock_keeping_unit: sku3,
  distribution_center: dc_th,
  quantity_reserved: 0,
  quantity_shipped: 0,
  quantity_available: 0
)
