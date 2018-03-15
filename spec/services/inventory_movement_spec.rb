require 'rails_helper'

RSpec.describe InventoryMovement, type: :services do
  describe '#receive' do
    let!(:inventory) { create :inventory }

    it 'should increare the quantity available' do
      expect do
        InventoryMovement.new(inventory, 10).receive
      end.to change { inventory.reload.quantity_available }.by(10)
    end
  end
end
