module Api
  # Controller for Inventories
  class InventoriesController < ApplicationController
    include JsonErrors

    before_action :find_inventory, only: %i[addition reduction reserve]
    before_action :distribution_centers, only: %i[current_stock_on_hand current_pending_shipped]

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

    def reserve
      if @inventory
        InventoryMovement.new(
          @inventory, inventory_params[:quantity].to_i
        ).reserve
        render template: 'api/inventories/inventory', status: :ok
      else
        error
      end
    end

    def current_stock_on_hand
      render template: 'api/inventories/current_stock_on_hand', status: :ok
    end

    def current_pending_shipped
      render template: 'api/inventories/current_pending_shipped', status: :ok
    end

    private

    def distribution_center
      @distribution_center =
        DistributionCenter.find_by(
          country: inventory_params[:distribution_center]
        )
    end

    def distribution_centers
      @distribution_centers =
        DistributionCenter.all.includes(:inventories, inventories: :stock_keeping_unit)
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

    def inventory_params
      params.require(:inventory).permit(
        :quantity, :distribution_center, :stock_keeping_unit
      )
    end
  end
end
