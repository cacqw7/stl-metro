FactoryGirl.define do
  factory :route do
    route_type '3' # bus
    sequence(:route_id, 100) { |n| n }
    route_short_name { SecureRandom.random_number(100) }
    route_long_name { FFaker::Lorem.word }
  end
end
