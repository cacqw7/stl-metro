require 'rails_helper'

describe Stop, type: :model do
  describe "Associations" do
    it { should have_many :stop_times }
    it { should have_many(:trips).through(:stop_times) }
  end

  describe "Validations" do
    it { should validate_presence_of :stop_name }
    it { should validate_presence_of :stop_latlon }
  end

  describe "#departures" do
    after { Timecop.return }

    let!(:stop) { create(:stop) }
    3.times do |i|
      let!("route#{i}".to_sym) { create(:route) }
      let!("trip#{i}".to_sym) { create(:trip, :with_route, :with_available_calendar) }
    end

    let!(:stop_time0) { create(:stop_time, stop: stop, departure_hour: 12, departure_minute: 44, trip: trip0)}
    let!(:stop_time1) { create(:stop_time, stop: stop, departure_hour: 26, departure_minute: 25, trip: trip1)}
    let!(:stop_time2) { create(:stop_time, stop: stop, departure_hour: 7, departure_minute: 12, trip: trip2)}

    it "should list all the upcoming departures for the stop" do
      Timecop.freeze(DateTime.parse "12:23 CDT") do
        expect(stop.departures).to eq [
          [stop.stop_times.first, stop.stop_times.first.trip.route],
          [stop.stop_times.second, stop.stop_times.second.trip.route]
        ]
      end
    end
  end
end
