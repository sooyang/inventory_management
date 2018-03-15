# Class to handle inventory movements
class InventoryMovement
  def initialize(inventory, quantity)
    @inventory = inventory
    @quantity = quantity
  end

  def receive
    @inventory.increment!(:quantity_available, @quantity)
  end

  def shipped
    @inventory.decrement!(:quantity_available, @quantity)
    @inventory.increment!(:quantity_shipped, @quantity)
  end
end
