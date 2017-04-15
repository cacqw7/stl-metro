require 'rails_helper'

describe Shape, type: :model do
  describe "Validations" do
    it { should validate_presence_of :shape_pt_lat }
    it { should validate_presence_of :shape_pt_lon }
    it { should validate_presence_of :shape_pt_sequence }
  end
end
