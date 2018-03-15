require 'rails_helper'

RSpec.describe InventoryMovement, type: :services do
  describe '#receive' do
    let!(:inventory) { create :inventory }

    it 'should increase the quantity available' do
      expect do
        InventoryMovement.new(inventory, 10).receive
      end.to change { inventory.reload.quantity_available }.by(10)
    end
  end

  describe '#reduction' do
    let!(:inventory) { create :inventory }

    it 'should reduce the quantity available' do
      expect do
        InventoryMovement.new(inventory, 10).shipped
      end.to change { inventory.reload.quantity_available }.by(-10)
    end

    it 'should increase the quantity shipped' do
      expect do
        InventoryMovement.new(inventory, 10).shipped
      end.to change { inventory.reload.quantity_shipped }.by(10)
    end
  end
end
