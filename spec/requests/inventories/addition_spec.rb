require 'rails_helper'

describe 'POST /api/inventories/addition', type: :request do
  let!(:stock_keeping_units) { create_list :stock_keeping_unit, 5}
  let!(:sg_center) { create :distribution_center, country: 'Singapore'}
  let!(:th_center) { create :distribution_center, country: 'Thailand'}

  context 'with valid params' do
    before do
      inventory_params = {
        params: {
          inventory: {
            quantity: 10,
            distribution_center: sg_center.country,
            stock_keeping_unit: stock_keeping_units.last
          }
        }
      }
      post('/api/inventories/addition', inventory_params)
    end

    it 'returns status success' do
      expect(response).to have_http_status(:ok)
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
      post('/api/inventories/addition', inventory_params)
    end

    it 'returns status bad request' do
      expect(response).to have_http_status(:bad_request)
    end
  end
end
