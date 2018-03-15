module Api
  # Controller for Inventories
  class InventoriesController < ApplicationController
    include JsonErrors

    before_action :find_inventory, only: %i[addition reduction]

    def addition
      if @inventory
        InventoryMovement.new(
          @inventory, inventory_params[:quantity].to_i
        ).receive
        render template: 'api/inventories/inventory', status: :ok
      else
        error
      end
    end

    def reduction
      if @inventory
        InventoryMovement.new(
          @inventory, inventory_params[:quantity].to_i
        ).shipped
        render template: 'api/inventories/inventory', status: :ok
      else
        error
      end
    end

    private

    def distribution_center
      @distribution_center =
        DistributionCenter.find_by(
          country: inventory_params[:distribution_center]
        )
    end

    def stock_keeping_unit
      @stock_keeping_unit =
        StockKeepingUnit.find_by(code: inventory_params[:stock_keeping_unit])
    end

    def find_inventory
      @inventory = Inventory.find_by(
        distribution_center: distribution_center,
        stock_keeping_unit: stock_keeping_unit
      )
    end

    def inventory_params
      params.require(:inventory).permit(
        :quantity, :distribution_center, :stock_keeping_unit
      )
    end
  end
end
