# Class to handle inventory movements
class InventoryMovement
  def initialize(inventory, quantity)
    @inventory = inventory
    @quantity = quantity
  end

  def receive
    @inventory.increment(:quantity_available, @quantity)
    @inventory.save
    @inventory
  end

  def shipped
    @inventory.decrement(:quantity_available, @quantity)
    @inventory.increment(:quantity_shipped, @quantity)
    @inventory.save
    @inventory
  end

  def reserve
    @inventory.decrement(:quantity_available, @quantity)
    @inventory.increment(:quantity_reserved, @quantity)
    @inventory.save
    @inventory
  end
end
