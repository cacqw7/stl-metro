FactoryGirl.define do
  factory :trip do
    sequence(:trip_id, 100) { |n| n }

    trait :with_route do
      after(:create) do |trip|
        route = create(:route)
        trip.update(route_id: route.route_id)
      end
    end

    trait :with_available_calendar do
      after(:create) do |trip|
        service_id = FFaker::Internet.slug
        create(:calendar, :available, service_id: service_id)
        trip.update(service_id: service_id)
      end
    end
  end
end
