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

  describe "#routes" do
    let!(:route)      { create(:route) }
    let!(:trip)       { create(:trip, route: route) }
    let!(:stop)       { create(:stop) }
    let!(:stop_time) { create(:stop_time, stop: stop, trip: trip) }

    it "should list all the routes that use the stop" do
      expect(stop.route_short_names).to eq([route.route_short_name])
    end
  end

  describe "#departures" do
    after { Timecop.return }

    let!(:stop) { create(:stop) }
    3.times do |i|
      let!("route#{i}".to_sym) { create(:route) }
      let!("trip#{i}".to_sym) { create(:trip, route: public_send("route#{i}")) }
    end

    let!(:stop_time0) { create(:stop_time, stop: stop, departure_hour: 12, departure_minute: 44, trip: trip0)}
    let!(:stop_time1) { create(:stop_time, stop: stop, departure_hour: 26, departure_minute: 25, trip: trip1)}
    let!(:stop_time2) { create(:stop_time, stop: stop, departure_hour: 7, departure_minute: 12, trip: trip2)}

    it "should list all the upcoming departures for the stop" do
      Timecop.freeze(Time.local(2017, 12, 12, 12, 43)) do
        expect(stop.departures).to eq([[stop_time0, route0],[stop_time1, route1]])
      end
    end
  end
end
