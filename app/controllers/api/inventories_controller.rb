module Api
  # Controller for Inventories
  class InventoriesController < ApplicationController
    before_action :find_inventory, only: [:addition]

    def addition
      if @inventory
        @inventory.increment!(:quantity_available, by = inventory_params[:quantity].to_i)
      else
        #raise an error
        render json: {status: "error", code: 3000, message: "Can't find inventory belonging to Distribution Center or SKU"}, status: 400
      end
    end

    private

    def distribution_center
      @distribution_center = DistributionCenter.find_by(country: inventory_params[:distribution_center])
    end

    def stock_keeping_unit
      @stock_keeping_unit = StockKeepingUnit.find_by(code: inventory_params[:stock_keeping_unit])
    end

    def find_inventory
      @inventory = Inventory.find_by(
        distribution_center: distribution_center,
        stock_keeping_unit: stock_keeping_unit
      )
    end

    def inventory_params
      params.require(:inventory).permit(:quantity, :distribution_center, :stock_keeping_unit)
    end
  end
end
