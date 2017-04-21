require 'rails_helper'

describe Trip, type: :model do
  describe "Associations" do
    it { should have_many :stop_times }
    it { should have_many :shapes }
    it { should belong_to :route }
  end
end
