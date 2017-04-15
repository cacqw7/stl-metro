require 'rails_helper'

describe Agency, type: :model do
  describe "Validations" do
    it { should validate_presence_of :agency_name }
    it { should validate_presence_of :agency_url }
    it { should validate_presence_of :agency_timezone }
  end
end
