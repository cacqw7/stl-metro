require 'rails_helper'

describe Stop, type: :model do
  describe "Associations" do
    it { should have_many :stop_times }
  end

  describe "Validations" do
    it { should validate_presence_of :stop_name }
    it { should validate_presence_of :stop_lat }
    it { should validate_presence_of :stop_lon }
  end
end
