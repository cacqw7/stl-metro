FactoryGirl.define do
  factory :trip do
    sequence(:trip_id, 100) { |n| n }
  end

  factory :stop_time do
    arrival_hour { SecureRandom.random_number(26) }
    arrival_minute { SecureRandom.random_number(60) }
    arrival_second { SecureRandom.random_number(60) }
    departure_hour { SecureRandom.random_number(26) }
    departure_minute { SecureRandom.random_number(60) }
    departure_second { SecureRandom.random_number(60) }
    stop_sequence { SecureRandom.random_number(100) }
  end

  factory :route do
    sequence(:route_id, 100) { |n| n }
    route_short_name { SecureRandom.random_number(100) }
    route_long_name { FFaker::Lorem.word }
    route_type 3
  end

  factory :stop do
    sequence(:stop_id, 100) { |n| n }
    stop_name { FFaker::Address.street_name }
    stop_latlon { '0101000020E610000043CBBA7F2C50434000000000008056C0' }
  end
end
