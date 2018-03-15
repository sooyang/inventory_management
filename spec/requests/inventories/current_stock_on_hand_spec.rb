require 'rails_helper'

describe 'GET /api/inventories/current_stock_on_hand', type: :request do
  let!(:stock_keeping_units) { create_list :stock_keeping_unit, 5 }
  let!(:sg_center) { create :distribution_center, country: 'Singapore' }
  let!(:th_center) { create :distribution_center, country: 'Thailand' }
  let!(:inventory) do
    create :inventory, distribution_center: sg_center,
                       stock_keeping_unit: stock_keeping_units.last
  end

  before do
    get('/api/inventories/current_stock_on_hand')
  end

  it 'returns status success' do
    expect(response).to have_http_status(:ok)
  end

  it 'returns the current stock on hand report' do
    expect(JSON.parse(response.body, symbolize_names: true)).to eq(
      [
        DistributionCenter.all.map do |distribution_center|
          {
            distribution_center: {
              id: distribution_center.id,
              country: distribution_center.country,
              inventories: [
                distribution_center.inventories.map do |inventory|
                  {
                    id: inventory.id,
                    stock_keeping_unit: {
                      id: inventory.stock_keeping_unit.id,
                      code: inventory.stock_keeping_unit.code,
                      created_at: inventory.stock_keeping_unit.created_at.to_i,
                      updated_at: inventory.stock_keeping_unit.updated_at.to_i
                    },
                    quantity_available: inventory.quantity_available,
                    created_at: inventory.created_at.to_i,
                    updated_at: inventory.updated_at.to_i
                  }
                end
              ].flatten,
              created_at: distribution_center.created_at.to_i,
              updated_at: distribution_center.updated_at.to_i
            }
          }
        end
      ].flatten
    )
  end
end
