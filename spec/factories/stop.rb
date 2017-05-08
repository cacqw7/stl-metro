FactoryGirl.define do
  factory :stop do
    sequence(:stop_id, 100) { |n| n }
    stop_name { FFaker::Address.street_name }
    stop_latlon { '0101000020E610000043CBBA7F2C50434000000000008056C0' }
  end
end
