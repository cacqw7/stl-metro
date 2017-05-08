require 'rails_helper'

describe Calendar, type: :model do
  describe "Associations" do
    it { should have_many :calendar_dates }
  end

  describe "Validations" do
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
    it { should validate_presence_of :monday }
    it { should validate_presence_of :tuesday }
    it { should validate_presence_of :wednesday }
    it { should validate_presence_of :thursday }
    it { should validate_presence_of :friday }
    it { should validate_presence_of :saturday }
    it { should validate_presence_of :sunday }
  end

  describe "#available?" do
    let!(:now) { DateTime.now }
    let(:calendar) { create(:available_calendar, start_date: now - 1.week) }

    describe "when the current time is within the calendar's range" do
      describe "when service is available on that weekday" do
        it { expect(calendar.available?).to be_truthy }
      end

      describe "when services is unavailable on that weekday" do
        let(:calendar) { create(:unavailable_calendar, start_date: now - 1.week) }
        it { expect(calendar.available?).to be_falsey }
      end
    end

    describe "when the current time is outside the calendar's range" do
      let(:calendar) { create(:available_calendar, start_date: now - 1.year) }
      it { expect(calendar.available?).to be_falsey }
    end
  end
end
