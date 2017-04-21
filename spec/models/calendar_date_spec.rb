require 'rails_helper'

describe CalendarDate, type: :model do
  describe "Associations" do
    it { should belong_to :calendar }
  end

  describe "Validations" do
    it { should validate_presence_of :date }
    it { should validate_presence_of :exception_type }
  end
end
