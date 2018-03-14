require 'rails_helper'

describe 'POST /api/stock_keeping_units', type: :request do
  context 'with valid params' do
    before do
      stock_keeping_unit_params = {
        params: {
          stock_keeping_unit: {
            code: 'A0000001'
          }
        }
      }

      post('/api/stock_keeping_units', stock_keeping_unit_params)
    end

    it 'returns status success' do
      expect(response).to have_http_status(:created)
    end

    it 'return the created object json response' do
      stock = StockKeepingUnit.find_by(code: 'A0000001')
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(
        id: stock.id,
        code: stock.code,
        created_at: stock.created_at.to_i,
        updated_at: stock.updated_at.to_i
      )
    end
  end

  context 'with invalid params' do
    before do
      stock_keeping_unit_params = {
        params: {
          stock_keeping_unit: {
            code: nil
          }
        }
      }

      post('/api/stock_keeping_units', stock_keeping_unit_params)
    end

    it 'returns status bad request' do
      expect(response).to have_http_status(:bad_request)
    end

    it 'return an error message' do
      expect(JSON.parse(response.body, symbolize_names: true)).to eq(
        errors: [
          "Code can't be blank"
        ]
      )
    end
  end
end
