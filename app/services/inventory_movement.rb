# Class to handle inventory movements
class InventoryMovement
  def initialize(inventory, quantity)
    @inventory = inventory
    @quantity = quantity
  end

  def receive
    @inventory.increment!(:quantity_available, @quantity)
  end
end
