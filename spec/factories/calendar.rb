FactoryGirl.define do
  factory :calendar do
    start_date { DateTime.now - 1.day }
    end_date { start_date + 1.month }

    trait :unavailable do
      monday 0
      tuesday 0
      wednesday 0
      thursday 0
      friday 0
      saturday 0
      sunday 0
    end

    trait :available do
      monday 1
      tuesday 1
      wednesday 1
      thursday 1
      friday 1
      saturday 1
      sunday 1
    end

    factory :unavailable_calendar, traits: [:unavailable]
    factory :available_calendar, traits: [:available]
  end
end
