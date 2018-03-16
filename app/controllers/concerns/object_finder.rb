# Module for providing finder helpers
module ObjectFinder
  def distribution_center
    @distribution_center =
      DistributionCenter.find_by(
        country: inventory_params[:distribution_center].capitalize
      )
  end

  def distribution_centers
    @distribution_centers =
      DistributionCenter.all.includes(
        :inventories, inventories: :stock_keeping_unit
      )
  end

  def stock_keeping_unit
    @stock_keeping_unit =
      StockKeepingUnit.find_by(code: inventory_params[:stock_keeping_unit])
  end

  def find_inventory
    return unless stock_keeping_unit && distribution_center
    @inventory = Inventory.find_or_create_by(
      distribution_center: distribution_center,
      stock_keeping_unit: stock_keeping_unit
    )
  end
end
