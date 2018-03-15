FactoryGirl.define do
  factory :stock_keeping_unit do
    sequence(:code) { |n| "SKU00000#{n}" }
  end
end
