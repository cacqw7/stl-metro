require 'rails_helper'

describe Route, type: :model do
  describe "Validations" do
    it { should validate_presence_of :route_short_name }
    it { should validate_presence_of :route_long_name }
    it { should validate_presence_of :route_type }
  end
end
