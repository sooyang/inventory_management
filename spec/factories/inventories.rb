FactoryGirl.define do
  factory :inventory do
    distribution_center
    stock_keeping_unit
    quantity_reserved 0
    quantity_shipped 0
    quantity_available 0
  end
end
