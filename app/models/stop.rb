class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'
  has_many :trips, through: :stop_times

  validates_presence_of :stop_name,
                        :stop_latlon

  def route_short_names
    trips.includes(:route).pluck(:route_short_name).uniq
  end
end
