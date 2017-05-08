require 'rails_helper'

describe Route, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :route_short_name }
    it { should validate_presence_of :route_long_name }
    it { should validate_presence_of :route_type }
  end

  describe '#name' do
    let(:short_name) { '42' }
    let(:long_name) { 'Rhodes' }
    let(:route) do
      create(:route,
             route_short_name: short_name,
             route_long_name: long_name)
    end

    it 'combines the short and long names' do
      expect(route.name).to eq('42 Rhodes')
    end
  end
end
