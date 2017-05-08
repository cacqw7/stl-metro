class Stop < ApplicationRecord
  has_many :stop_times, primary_key: 'stop_id'
  has_many :trips, through: :stop_times

  validates_presence_of :stop_name,
                        :stop_latlon

  def route_short_names
    trips.includes(:route).pluck(:route_short_name).uniq
  end

  def departures
    upcoming.each_with_object([]) do |stop_time, departures|
      departures << [stop_time, stop_time.trip.route]
    end
  end

  def upcoming
    now = DateTime.now
    stop_times.where('departure_hour >= ?', now.hour).reject do |st|
      st.departure_hour == now.hour && st.departure_minute < now.minute
    end.sort_by { |e| [e.departure_hour, e.departure_minute]  }
  end
end
