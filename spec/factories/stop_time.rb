FactoryGirl.define do
  factory :stop_time do
    arrival_hour { SecureRandom.random_number(26) }
    arrival_minute { SecureRandom.random_number(60) }
    arrival_second { SecureRandom.random_number(60) }
    departure_hour { SecureRandom.random_number(26) }
    departure_minute { SecureRandom.random_number(60) }
    departure_second { SecureRandom.random_number(60) }
    stop_sequence { SecureRandom.random_number(100) }
  end
end
