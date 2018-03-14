module Api
  # Controller for StockKeepingUnits
  class StockKeepingUnitsController < ApplicationController
    def create
      @stock_keeping_unit = StockKeepingUnit.new(stock_keeping_unit_params)

      if @stock_keeping_unit.save
        render template: 'api/stock_keeping_units/create', status: :created
      else
        render json: { errors: @stock_keeping_unit.errors.full_messages },
               status: :bad_request
      end
    end

    private

    def stock_keeping_unit_params
      params.require(:stock_keeping_unit).permit(:code)
    end
  end
end
