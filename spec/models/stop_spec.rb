require 'rails_helper'

describe Stop, type: :model do
  describe "Associations" do
    it { should have_many :stop_times }
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
end
