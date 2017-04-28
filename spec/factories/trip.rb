FactoryGirl.define do
  factory :trip do
    sequence(:trip_id, 100) { |n| n }
  end
end
