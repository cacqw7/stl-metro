class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'

  validates_presence_of :stop_name,
                        :stop_latlon

  def route_short_names
    stop_times.includes(trip: :route).pluck(:route_short_name).uniq
  end
end
