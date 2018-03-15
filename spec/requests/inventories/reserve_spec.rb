require 'rails_helper'

describe 'POST /api/inventories/reserve', type: :request do
  let!(:stock_keeping_units) { create_list :stock_keeping_unit, 5 }
  let!(:sg_center) { create :distribution_center, country: 'Singapore' }
  let!(:th_center) { create :distribution_center, country: 'Thailand' }
  let!(:inventory) do
    create :inventory, distribution_center: sg_center,
                       stock_keeping_unit: stock_keeping_units.last,
                       quantity_available: 100
  end

  context 'with valid params' do
    context 'with sufficient inventories' do
      before do
        inventory_params = {
          params: {
            inventory: {
              quantity: 10,
              distribution_center: sg_center.country,
              stock_keeping_unit: stock_keeping_units.last.code
            }
          }
        }

        post('/api/inventories/reserve', inventory_params)
      end

      it 'returns status success' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the updated inventory in json' do
        inventory.reload
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          id: inventory.id,
          distribution_center_id: inventory.distribution_center.id,
          stock_keeping_unit_id: inventory.stock_keeping_unit.id,
          quantity_reserved: inventory.quantity_reserved,
          quantity_shipped: inventory.quantity_shipped,
          quantity_available: inventory.quantity_available,
          created_at: inventory.created_at.to_i,
          updated_at: inventory.updated_at.to_i
        )
      end
    end

    context 'with insufficient inventories' do
      before do
        inventory_params = {
          params: {
            inventory: {
              quantity: 1000,
              distribution_center: sg_center.country,
              stock_keeping_unit: stock_keeping_units.last.code
            }
          }
        }

        post('/api/inventories/reserve', inventory_params)
      end

      it 'returns status bad request' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'return an error message' do
        expect(JSON.parse(response.body, symbolize_names: true)).to eq(
          errors: [
            "Quantity available must be greater than or equal to 0"
          ]
        )
      end
    end
  end

  context 'with invalid params' do
    before do
      inventory_params = {
        params: {
          inventory: {
            quantity: 10,
            distribution_center: 'Invalid Country',
            stock_keeping_unit: 'Invalid Code'
          }
        }
      }
      post('/api/inventories/reserve', inventory_params)
    end

    it 'returns status bad request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'return an error message' do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(
        status: 'error',
        message: "Can't find inventory belonging to Distribution Center/SKU"
      )
    end
  end
end
