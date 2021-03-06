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
end
