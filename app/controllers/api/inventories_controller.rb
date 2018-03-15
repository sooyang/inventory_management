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
        reduce_inventory
        reduce_inventory_response
      else
        error
      end
    end

    def reserve
      if @inventory
        reserve_inventory
        reserve_inventory_response
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

    def reduce_inventory
      @inventory_shipped = InventoryMovement.new( @inventory, inventory_params[:quantity].to_i ).shipped
    end

    def reduce_inventory_response
      if @inventory_shipped.errors.present?
        render json: { errors: @inventory_shipped.errors.full_messages },
               status: :bad_request
      else
        render template: 'api/inventories/inventory', status: :ok
      end
    end

    def reserve_inventory
      @inventory_reserved = InventoryMovement.new(
        @inventory, inventory_params[:quantity].to_i
      ).reserve
    end

    def reserve_inventory_response
      if @inventory_reserved.errors.present?
        render json: { errors: @inventory_reserved.errors.full_messages },
               status: :bad_request
      else
        render template: 'api/inventories/inventory', status: :ok
      end
    end

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
