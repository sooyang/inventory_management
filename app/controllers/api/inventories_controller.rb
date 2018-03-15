module Api
  # Controller for Inventories
  class InventoriesController < ApplicationController
    include JsonErrors
    include ObjectFinder

    before_action :find_inventory, only: %i[addition reduction reserve]
    before_action :distribution_centers,
                  only: %i[current_stock_on_hand current_pending_shipped]

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
        inventory_shipped = InventoryMovement.new(
          @inventory, inventory_params[:quantity].to_i
        ).shipped
        inventory_response(inventory_shipped)
      else
        error
      end
    end

    def reserve
      if @inventory
        inventory_reserved = InventoryMovement.new(
          @inventory, inventory_params[:quantity].to_i
        ).reserve
        inventory_response(inventory_reserved)
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

    def inventory_response(inventory)
      if inventory.errors.present?
        render json: { errors: inventory.errors.full_messages },
               status: :bad_request
      else
        render template: 'api/inventories/inventory', status: :ok
      end
    end

    def inventory_params
      params.require(:inventory).permit(
        :quantity, :distribution_center, :stock_keeping_unit
      )
    end
  end
end
