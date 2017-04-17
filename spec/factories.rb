FactoryGirl.define do
  factory :stop_time do
    trip
    stop
    arrival_hour { random_number(0..26) }
    arrival_minute { random_number(0..60) }
    arrival_second { random_number(0..60) }
    departure_hour { random_number(0..26) }
    departure_minute { random_number(0..60) }
    departure_second { random_number(0..60) }
    stop_sequence { random_number(0..100) }
  end

  def random_number(range)
    (range).to_a.sample
  end

  factory :trip do

  end

  factory :stop do
    
  end
end
