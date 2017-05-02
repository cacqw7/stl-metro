require 'rails_helper'

describe StopTime, type: :model do
  describe "Associations" do
    it { should belong_to :trip }
    it { should belong_to :stop }
    it { should have_many(:calendars).through(:trip) }
    it { should have_many(:calendar_dates).through(:trip) }
  end

  describe "Validations" do
    it { should validate_presence_of :arrival_hour }
    it { should validate_presence_of :arrival_minute }
    it { should validate_presence_of :arrival_second }
    it { should validate_presence_of :departure_hour }
    it { should validate_presence_of :departure_minute }
    it { should validate_presence_of :departure_second }
    it { should validate_presence_of :stop_id }
    it { should validate_presence_of :stop_sequence }
  end
end
